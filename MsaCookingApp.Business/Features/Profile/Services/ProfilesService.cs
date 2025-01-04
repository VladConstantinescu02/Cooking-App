using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using MsaCookingApp.Business.Shared.Exceptions;
using MsaCookingApp.Contracts.Features.Profile.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Profile.DTOs;
using MsaCookingApp.Contracts.Shared.Abstractions.Repositories;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;
using MsaCookingApp.Contracts.Shared.DTOs;
using MsaCookingApp.DataAccess.Entities;
using MsaCookingApp.DataAccess.Repositories.Abstractions;
using ILogger = Microsoft.Extensions.Logging.ILogger;

namespace MsaCookingApp.Business.Features.Profile.Services;

public class ProfilesService : IProfilesService
{
    private readonly IRepository<DataAccess.Entities.Profile> _profileRepository;
    private readonly IRepository<Ingredient> _ingredientRepository;
    private readonly IUserRepository _userRepository;
    private readonly IRepository<DietaryOption> _dietaryOptionRepository;
    private readonly ILogger _logger;
    private readonly ISpoonacularApiService _spoonacularApiService;
    private readonly IMapper _mapper;

    public ProfilesService(IRepository<DataAccess.Entities.Profile> profileRepository, ILogger<ProfilesService> logger, IUserRepository userRepository, IRepository<Ingredient> ingredientRepository, ISpoonacularApiService spoonacularApiService, IRepository<DietaryOption> dietaryOptionRepository, IMapper mapper)
    {
        _profileRepository = profileRepository;
        _logger = logger;
        _userRepository = userRepository;
        _ingredientRepository = ingredientRepository;
        _spoonacularApiService = spoonacularApiService;
        _dietaryOptionRepository = dietaryOptionRepository;
        _mapper = mapper;
    }

    public async Task<GetProfileResponseDto> GetProfileAsync(string? userEmail)
    {
        try
        {
            var foundUser = (await _userRepository.FindAsync((u) => u.Email == userEmail)).FirstOrDefault();
            if (foundUser == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User not found");
            }

            var foundProfile = (await _profileRepository.FindAsync((p) => p.UserId == foundUser.Id)).FirstOrDefault();
            if (foundProfile == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User does not have a profile");
            }

            var profileAlergens = foundProfile.IngredientAllergies.Select(a => _mapper.Map<ProfileAlergenDto>(a))
                .ToList();
            var profileDietaryRestriction = _mapper.Map<ProfileDietRestricionDto>(foundProfile.DietaryOption);
            var profile = GetProfileDto.Create(foundProfile.Id, foundProfile.UserName, foundProfile.FullName,
                foundProfile.UserId, foundProfile.ProfilePhotoUrl, profileAlergens, profileDietaryRestriction);

            return GetProfileResponseDto.Create("Successfully retrieved profile", profile);
        }
        catch (Exception e)
        {
            _logger.LogError($"Error when retrieving profile {e}");
            throw;
        }
    }

    public async Task<CreateProfileResponseDto> CreateProfileAsync(CreateProfileDto createProfileDto, string? userEmail)
    {
        try
        {
            var foundUser = (await _userRepository.FindAsync((u) => u.Email == userEmail)).FirstOrDefault();
            if (foundUser == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User not found");
            }

            var foundProfile = await _profileRepository.FindAsync((p) => p.UserId == foundUser.Id);
            if (foundProfile.Any())
            {
                throw new ServiceException(StatusCodes.Status409Conflict, "User already has profile");
            }

            var newProfile =
                DataAccess.Entities.Profile.Create(createProfileDto.UserName, foundUser.DisplayName, foundUser.Id);

            if (!string.IsNullOrEmpty(createProfileDto.ProfilePhotoUrl))
            {
                newProfile.ProfilePhotoUrl = createProfileDto.ProfilePhotoUrl;
            }

            if (createProfileDto.IngredientAllergies != null && createProfileDto.IngredientAllergies.Any())
            {
                await SaveIngredientsAsync(createProfileDto.IngredientAllergies, newProfile);
            }

            if (createProfileDto.DietaryOptionId != null)
            {
                newProfile.DietaryOptionId = createProfileDto.DietaryOptionId;
            }
            else
            {
                if (!string.IsNullOrEmpty(createProfileDto.NewDietaryOption))
                {
                    await SaveNewDietaryOptionAsync(createProfileDto.NewDietaryOption, newProfile);
                }
            }

            await _profileRepository.AddAsync(newProfile);
            return CreateProfileResponseDto.Create("Successfully created profile");
        }
        catch (Exception e)
        {
            _logger.LogError($"Error when creating profile {e}");
            throw;
        }
    }

    public async Task<UpdateProfileResponseDto> UpdateProfileAsync(UpdateProfileDto updateProfileDto, string? userEmail)
    {
        try
        {
            var foundUser = (await _userRepository.FindAsync((u) => u.Email == userEmail)).FirstOrDefault();
            if (foundUser == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User not found");
            }

            var foundProfile = (await _profileRepository.FindAsync((p) => p.UserId == foundUser.Id)).FirstOrDefault();
            if (foundProfile == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User has no profile");
            }

            foundProfile.UserName = updateProfileDto.UserName;
            foundProfile.ProfilePhotoUrl = updateProfileDto.ProfilePhotoUrl;
            
            if (updateProfileDto.IngredientAllergies != null && updateProfileDto.IngredientAllergies.Any())
            {
                await UpdateIngredientsAsync(updateProfileDto.IngredientAllergies, foundProfile);
            }
            else
            {
                foundProfile.IngredientAllergies = new List<Ingredient>();
            }

            if (updateProfileDto.DietaryOptionId != null)
            {
                foundProfile.DietaryOptionId = updateProfileDto.DietaryOptionId;
            }
            else
            {
                if (!string.IsNullOrEmpty(updateProfileDto.NewDietaryOption))
                {
                    await SaveNewDietaryOptionAsync(updateProfileDto.NewDietaryOption, foundProfile);
                }
                else
                {
                    foundProfile.DietaryOptionId = null;   
                }
            }
            await _profileRepository.UpdateAsync(foundProfile, foundProfile.Id);
            return UpdateProfileResponseDto.Create("Successfully updated profile");
        }
        catch (Exception e)
        {
            _logger.LogError($"Error when updating profile {e}");
            throw;
        }
    }

    public async Task<DeleteProfileResponseDto> DeleteProfileAsync(string? userEmail)
    {
        try
        {
            var foundUser = (await _userRepository.FindAsync((u) => u.Email == userEmail)).FirstOrDefault();
            if (foundUser == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User not found");
            }

            var foundProfile = (await _profileRepository.FindAsync((p) => p.UserId == foundUser.Id)).FirstOrDefault();
            if (foundProfile == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User does not have a profile");
            }

            foreach (var foundProfileIngredientAllergy in foundProfile.IngredientAllergies)
            {
                foundProfileIngredientAllergy.AllergicProfiles.Remove(foundProfile);
            }

            await _profileRepository.RemoveAsync(foundProfile);
            return DeleteProfileResponseDto.Create("Successfully deleted profile");
        }
        catch (Exception e)
        {
            _logger.LogError($"Error when deleting profile {e}");
            throw;
        }
    }

    public async Task<SearchDietaryOptionsResultDto> SearchDietaryOptionAsync(string query)
    {
        try
        {
            var formattedQuery = query.ToLower().Trim();
            var dietaryOptions = await _dietaryOptionRepository.GetAllAsync();
            var filteredDietaryOptions =
                dietaryOptions.Where(option => option.Name.ToLower().Trim().Contains(formattedQuery))
                    .Select(option => SearchDietaryOptionResult.Create(option.Id, option.Name));

            return SearchDietaryOptionsResultDto.Create("Successfully retrieved search results",
                filteredDietaryOptions);
        }
        catch (Exception e)
        {
            _logger.LogError($"Error when deleting profile {e}");
            throw;
        }
    }

    private async Task SaveIngredientsAsync(IEnumerable<string> ingredientIds, DataAccess.Entities.Profile profile)
    {
        foreach (var ingredientId in ingredientIds)
        {
            var foundIngredient = await _ingredientRepository.GetByIdAsync(ingredientId);
            if (foundIngredient != null)
            {
                profile.IngredientAllergies.Add(foundIngredient);
            }
            else
            {
                var spoonacularIngredient = await _spoonacularApiService.GetSpoonacularIngredientByIdAsync(ingredientId);
                var newIngredientCalories = spoonacularIngredient.Nutrition.Nutrients
                    .FirstOrDefault(n => n.Name == "Calories")?.Amount ?? 0; 
                var newIngredient = Ingredient.Create(spoonacularIngredient.Id , spoonacularIngredient.Name, newIngredientCalories);

                await _ingredientRepository.AddAsync(newIngredient);
                profile.IngredientAllergies.Add(newIngredient);
            }
        }
    }
    
    private async Task UpdateIngredientsAsync(IEnumerable<string> ingredientIds, DataAccess.Entities.Profile profile)
    {
        var enumerable = ingredientIds as string[] ?? ingredientIds.ToArray();
    
        var toRemove = profile.IngredientAllergies
            .Where(profileIngredientAllergy => !enumerable.Contains(profileIngredientAllergy.Id))
            .ToList();

        foreach (var profileIngredientAllergy in toRemove)
        {
            profile.IngredientAllergies.Remove(profileIngredientAllergy);
        }

        foreach (var ingredientId in enumerable)
        {
            if (profile.IngredientAllergies.Any(a => a.Id == ingredientId)) continue;

            var foundIngredient = await _ingredientRepository.GetByIdAsync(ingredientId);
            if (foundIngredient != null)
            {
                profile.IngredientAllergies.Add(foundIngredient);
            }
            else
            {
                var spoonacularIngredient = await _spoonacularApiService.GetSpoonacularIngredientByIdAsync(ingredientId);
                var newIngredientCalories = spoonacularIngredient.Nutrition.Nutrients
                    .FirstOrDefault(n => n.Name == "Calories")?.Amount ?? 0; 
                var newIngredient = Ingredient.Create(spoonacularIngredient.Id, spoonacularIngredient.Name, newIngredientCalories);

                await _ingredientRepository.AddAsync(newIngredient);
                profile.IngredientAllergies.Add(newIngredient);
            }
        }
    }
    
    private async Task SaveNewDietaryOptionAsync(string newDietaryOptionName, DataAccess.Entities.Profile profile)
    {
        var newDietaryOption = DietaryOption.Create(newDietaryOptionName);
        var newDietaryOptionAdded = await _dietaryOptionRepository.AddAndReturnEntityAsync(newDietaryOption);
        profile.DietaryOptionId = newDietaryOptionAdded?.Id;
    }
}