using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using MsaCookingApp.Business.Shared.Exceptions;
using MsaCookingApp.Contracts.Features.Fridge.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Fridge.DTOs;
using MsaCookingApp.Contracts.Shared.Abstractions.Repositories;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;
using MsaCookingApp.Contracts.Shared.DTOs;
using MsaCookingApp.DataAccess.Entities;
using MsaCookingApp.DataAccess.Repositories.Abstractions;

namespace MsaCookingApp.Business.Features.Fridge.Services;

public class FridgesService : IFridgesService
{
    private readonly ILogger<FridgesService> _logger;
    private readonly IRepository<DataAccess.Entities.Profile> _profileRepository;
    private readonly IUserRepository _userRepository;
    private readonly IRepository<DataAccess.Entities.Fridge> _fridgeRepository;
    private readonly IRepository<FridgeIngredient> _fridgeIngredientRepository;
    private readonly IRepository<IngredientMeasuringUnit> _ingredientMeasuringUnitRepository;
    private readonly ISpoonacularApiService _spoonacularApiService;
    private readonly IRepository<Ingredient> _ingredientsRepository;
    private readonly IMapper _mapper;

    public FridgesService(ILogger<FridgesService> logger, IRepository<DataAccess.Entities.Profile> profileRepository, IUserRepository userRepository, IRepository<DataAccess.Entities.Fridge> fridgeRepository, IRepository<FridgeIngredient> fridgeIngredientRepository, IRepository<IngredientMeasuringUnit> ingredientMeasuringUnitRepository, ISpoonacularApiService spoonacularApiService, IRepository<Ingredient> ingredientsRepository, IMapper mapper)
    {
        _logger = logger;
        _profileRepository = profileRepository;
        _userRepository = userRepository;
        _fridgeRepository = fridgeRepository;
        _fridgeIngredientRepository = fridgeIngredientRepository;
        _ingredientMeasuringUnitRepository = ingredientMeasuringUnitRepository;
        _spoonacularApiService = spoonacularApiService;
        _ingredientsRepository = ingredientsRepository;
        _mapper = mapper;
    }

    public async Task<AddFridgeIngredientResultDto> AddFridgeIngredientAsync(AddFridgeIngredientDto addFridgeIngredientDto, string? userEmail)
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

            var foundFridge = (await _fridgeRepository.FindAsync(f => f.ProfileId == foundProfile.Id)).FirstOrDefault();
            if (foundFridge == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User profile does not have a fridge");
            }

            var foundFridgeIngredient = (await _fridgeIngredientRepository.FindAsync(fi =>
                fi.FridgeId == foundFridge.Id && fi.IngredientId == addFridgeIngredientDto.IngredientId)).FirstOrDefault();
            if (foundFridgeIngredient != null)
            {
                throw new ServiceException(StatusCodes.Status409Conflict,
                    "You already have this ingredient in your fridge. Please modify its quantity");
            }

            var foundIngredientMeasuringUnit = await _ingredientMeasuringUnitRepository.GetByIdAsync(addFridgeIngredientDto.IngredientMeasuringUnitId);
            if (foundIngredientMeasuringUnit == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "Ingredient measuring unit not found");
            }

            var foundIngredient = await _ingredientsRepository.GetByIdAsync(addFridgeIngredientDto.IngredientId);
            if (foundIngredient == null)
            {
                var spoonacularIngredient =
                    await _spoonacularApiService.GetSpoonacularIngredientByIdAsync(addFridgeIngredientDto.IngredientId);
                var newIngredientCalories = spoonacularIngredient.Nutrition.Nutrients
                    .FirstOrDefault(n => n.Name == "Calories")?.Amount ?? 0;
                var newIngredient = Ingredient.Create(spoonacularIngredient.Id, spoonacularIngredient.Name,
                    newIngredientCalories);
                await _ingredientsRepository.AddAsync(newIngredient);
            }

            var newFridgeIngredient = FridgeIngredient.Create(foundFridge.Id, addFridgeIngredientDto.IngredientId,
                addFridgeIngredientDto.IngredientQuantity, addFridgeIngredientDto.IngredientMeasuringUnitId);

            await _fridgeIngredientRepository.AddAsync(newFridgeIngredient);

            return AddFridgeIngredientResultDto.Create($"Succesffully added new ingredient to {foundFridge.Name}");
        }
        catch (Exception e)
        {
            _logger.LogError($"Error when radding new ingredient to fridge {e}");
            throw;
        }
    }

    public async Task<UpdateFridgeIngredientResultDto> UpdateFridgeIngredientAsync(UpdateFridgeIngredientDto updateFridgeIngredientDto, string? userEmail)
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

            var foundFridge = (await _fridgeRepository.FindAsync(f => f.ProfileId == foundProfile.Id)).FirstOrDefault();
            if (foundFridge == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User profile does not have a fridge");
            }

            var foundFridgeIngredient = (await _fridgeIngredientRepository.FindAsync(fi =>
                fi.FridgeId == foundFridge.Id && fi.IngredientId == updateFridgeIngredientDto.IngredientId)).FirstOrDefault();
            if (foundFridgeIngredient == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound,
                    $"Ingredient not found");
            }

            var foundIngredientMeasuringUnit = await _ingredientMeasuringUnitRepository.GetByIdAsync(updateFridgeIngredientDto.IngredientMeasuringUnitId);
            if (foundIngredientMeasuringUnit == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "Ingredient measuring unit not found");
            }

            foundFridgeIngredient.Quantity = updateFridgeIngredientDto.IngredientQuantity;
            foundFridgeIngredient.IngredientMeasuringUnitId = updateFridgeIngredientDto.IngredientMeasuringUnitId;

            await _fridgeIngredientRepository.UpdateCompositeKeyAsync(foundFridgeIngredient, foundFridgeIngredient.FridgeId, foundFridgeIngredient.IngredientId);

            return UpdateFridgeIngredientResultDto.Create($"Succesffully updated ingredient");
        }
        catch (Exception e)
        {
            _logger.LogError($"Error when adding new ingredient to fridge {e}");
            throw;
        }
    }

    public async Task<DeleteFridgeIngredientResultDto> DeleteFridgeIngredientAsync(string fridgeIngredientId, string? userEmail)
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

            var foundFridge = (await _fridgeRepository.FindAsync(f => f.ProfileId == foundProfile.Id)).FirstOrDefault();
            if (foundFridge == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User profile does not have a fridge");
            }

            var foundFridgeIngredient = (await _fridgeIngredientRepository.FindAsync(fi =>
                fi.FridgeId == foundFridge.Id && fi.IngredientId == fridgeIngredientId)).FirstOrDefault();
            if (foundFridgeIngredient == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound,
                    $"Ingredient not found");
            }

            await _fridgeIngredientRepository.RemoveAsync(foundFridgeIngredient);

            return DeleteFridgeIngredientResultDto.Create($"Succesffully deleted fridge ingredient");
        }
        catch (Exception e)
        {
            _logger.LogError($"Error when deleting fridge ingredient {e}");
            throw;
        }
    }

    public async Task<GetFridgeResultDto> GetFridgeAsync(string? userEmail)
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

            var foundFridge = (await _fridgeRepository.FindAsync(f => f.ProfileId == foundProfile.Id)).FirstOrDefault();
            if (foundFridge == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User profile does not have a fridge");
            }

            var fridgeIngredients =
                (await _fridgeIngredientRepository.GetAllAsync()).Where(fi => fi.FridgeId == foundFridge.Id)
                .Select(fi => _mapper.Map<GetFridgeIngredientDto>(fi));

            var getFridgeIngredientDtos = fridgeIngredients as GetFridgeIngredientDto[] ?? fridgeIngredients.ToArray();
            var fridgeAlergensIds = getFridgeIngredientDtos.Where(fi =>
                    (foundProfile.IngredientAllergies.FirstOrDefault(a => a.Id == fi.IngredientId)) != null)
                .Select(fi => fi.IngredientId);

            var alergensIds = fridgeAlergensIds as string[] ?? fridgeAlergensIds.ToArray();
            var fridge = GetFridgeDto.Create(foundFridge.Name, getFridgeIngredientDtos, alergensIds);

            var warnings = alergensIds.Any()
                ? new List<WarningDto>() { WarningDto.Create("Your fridge contains alergens that may be bad for you") }
                : new List<WarningDto>(); 

            return GetFridgeResultDto.Create($"Successfully retrieved fridge {foundFridge.Name}", fridge, warnings);
        }
        catch (Exception e)
        {
            _logger.LogError($"Error when retrieving fridge {e}");
            throw;
        }
    }
}