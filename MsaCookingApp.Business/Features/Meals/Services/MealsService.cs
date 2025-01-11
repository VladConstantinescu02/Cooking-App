using System.Globalization;
using System.Text;
using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using MsaCookingApp.Business.Shared.Exceptions;
using MsaCookingApp.Business.Shared.Settings;
using MsaCookingApp.Contracts.Features.Meals.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Meals.DTOs;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;
using MsaCookingApp.DataAccess.Entities;
using MsaCookingApp.DataAccess.Repositories.Abstractions;
using Newtonsoft.Json;

namespace MsaCookingApp.Business.Features.Meals.Services;

public class MealsService : IMealsService
{
    private readonly IExceptionHandlingService _exceptionHandlingService;
    private readonly IRepository<DataAccess.Entities.Profile> _profileRepository;
    private readonly IUserRepository _userRepository;
    private readonly IRepository<DataAccess.Entities.Fridge> _fridgeRepository;
    private readonly SpoonacularOptions _spoonacularOptions;
    private readonly IRepository<MealCuisine> _mealCuisineRepository;
    private readonly IRepository<MealType> _mealTypeRepository;
    private readonly IRepository<FridgeIngredient> _fridgeIngredientRepository;
    private readonly ISpoonacularApiService _spoonacularApiService;
    private readonly IRepository<DietaryOption> _dietaryOptionRepository;
    private readonly IRepository<Meal> _mealsRepository;
    private readonly IMapper _mapper;

    public MealsService(IExceptionHandlingService exceptionHandlingService, IRepository<DataAccess.Entities.Profile> profileRepository, IUserRepository userRepository, IRepository<DataAccess.Entities.Fridge> fridgeRepository, IOptions<SpoonacularOptions> spoonacularOptions, IRepository<MealCuisine> mealCuisineRepository, IRepository<MealType> mealTypeRepository, IRepository<FridgeIngredient> fridgeIngredientRepository, ISpoonacularApiService spoonacularApiService, IRepository<DietaryOption> dietaryOptionRepository, IRepository<Meal> mealsRepository, IMapper mapper)
    {
        _exceptionHandlingService = exceptionHandlingService;
        _profileRepository = profileRepository;
        _userRepository = userRepository;
        _fridgeRepository = fridgeRepository;
        _mealCuisineRepository = mealCuisineRepository;
        _mealTypeRepository = mealTypeRepository;
        _fridgeIngredientRepository = fridgeIngredientRepository;
        _spoonacularApiService = spoonacularApiService;
        _dietaryOptionRepository = dietaryOptionRepository;
        _mealsRepository = mealsRepository;
        _mapper = mapper;
        _spoonacularOptions = spoonacularOptions.Value;
    }

    public async Task<SearchMealsResultDto> SearchMealsAsync(SearchMealsDto searchMealsDto, string? userEmail)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
        {
            var foundUser = (await _userRepository.FindAsync((u) => u.Email == userEmail)).FirstOrDefault();
            if (foundUser == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User not found");
            }

            var foundProfile = (await _profileRepository.FindAsync((p) => p.UserId == foundUser.Id)).FirstOrDefault(); if (foundProfile == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User does not have a profile");
            }

            var foundFridge = (await _fridgeRepository.FindAsync(f => f.ProfileId == foundProfile.Id)).FirstOrDefault();
            if (foundFridge == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "User profile does not have a fridge");
            }

            var foundMealType = await _mealTypeRepository.GetByIdAsync(searchMealsDto.MealTypeId);
            if (foundMealType == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound,
                    $"Meal type with id {searchMealsDto.MealTypeId} not found");
            }

            var spoonacularApiKey = _spoonacularOptions.ApiKey ?? "";
            var apiQuery =
                new StringBuilder(
                    $"/recipes/complexSearch?apiKey={spoonacularApiKey}&query={searchMealsDto.Query}&type={foundMealType.Type}&fillIngredients=true&limitLicense=true");

            
            if (searchMealsDto.UseProfileDiet)
            {
                var usedDiet = foundProfile.DietaryOption?.Name;
                apiQuery.Append($"&diet={usedDiet}");   
            }
            else
            {
                if (searchMealsDto.DietId != null)
                {
                    var foundDiet = await _dietaryOptionRepository.GetByIdAsync(searchMealsDto.DietId);
                    if (foundDiet == null)
                    {
                        throw new ServiceException(StatusCodes.Status404NotFound,
                            $"Diet with id {searchMealsDto.DietId} not found");
                    }
                    apiQuery.Append($"&diet={foundDiet.Name}");
                }
            }

            if (searchMealsDto.CuisineId != null)
            {
                var foundMealCuisine = await _mealCuisineRepository.GetByIdAsync(searchMealsDto.CuisineId);
                if (foundMealCuisine == null)
                {
                    throw new ServiceException(StatusCodes.Status404NotFound,
                        $"Meal cuisine with id {searchMealsDto.CuisineId} not found");
                }
                
                apiQuery.Append($"&cuisine={foundMealCuisine.Cuisine}");
            }

            if (searchMealsDto.MinCalories != null)
            {
                apiQuery.Append($"&minCalories={searchMealsDto.MinCalories}");
            }

            if (searchMealsDto.MaxCalories != null)
            {
                apiQuery.Append($"&maxCalories={searchMealsDto.MaxCalories}");
            }

            if (searchMealsDto.Ingredients != null && searchMealsDto.Ingredients.Any())
            {
                var foundFridgeIngredients =
                    (await _fridgeIngredientRepository.GetAllAsync()).Where(fi => fi.FridgeId == foundFridge.Id);
                var fridgeIngredients = foundFridgeIngredients as FridgeIngredient[] ?? foundFridgeIngredients.ToArray();
                var usedIngredientsCsv = new StringBuilder();
                
                if (searchMealsDto.UseAllFridgeIngredients)
                {
                    foreach (var foundFridgeIngredient in fridgeIngredients)
                    {
                        if (foundFridgeIngredient != fridgeIngredients.Last())
                        {
                            usedIngredientsCsv.Append($"{foundFridgeIngredient.Ingredient.Name},");
                        }
                        else
                        {
                            usedIngredientsCsv.Append(foundFridgeIngredient.Ingredient.Name);
                        }
                    }
                }
                else
                {
                    if (searchMealsDto.Ingredients != null)
                    {
                        foreach (var ingredientId in searchMealsDto.Ingredients)
                        {
                            var ingredient = fridgeIngredients.FirstOrDefault(fi => fi.IngredientId == ingredientId);
                            if (ingredient != fridgeIngredients.Last())
                            {
                                usedIngredientsCsv.Append($"{ingredient?.Ingredient.Name},");
                            }
                            else
                            {
                                usedIngredientsCsv.Append(ingredient.Ingredient.Name);
                            }
                        }
                    }
                }

                if (usedIngredientsCsv.Length > 0)
                {
                    apiQuery.Append($"&includeIngredients={usedIngredientsCsv.ToString()}");
                }   
            }

            if (searchMealsDto.IncludeProfileAlergens && searchMealsDto.ExcludedProfileAlergens != null)
            {
                var profileAlergens = foundProfile.IngredientAllergies;
                var excludedIngredientsCsv = new StringBuilder();
                foreach (var excludedProfileAlergenId in searchMealsDto.ExcludedProfileAlergens)
                {
                    var alergen = profileAlergens.FirstOrDefault(a => a.Id == excludedProfileAlergenId);
                    if (alergen != profileAlergens.Last())
                    {
                        excludedIngredientsCsv.Append($"{alergen?.Name},");
                    }
                    else
                    {
                        excludedIngredientsCsv.Append($"{alergen.Name}");
                    }
                }

                if (excludedIngredientsCsv.Length > 0)
                {
                    apiQuery.Append($"&excludeIngredients={excludedIngredientsCsv.ToString()}");
                }
            }

            var mealsSearchResult = await _spoonacularApiService.SearchSpoonacularMealAsync(apiQuery.ToString());
            if (mealsSearchResult != null)
            {
                return SearchMealsResultDto.Create("Successfully retrieved meals", mealsSearchResult);
            }

            return SearchMealsResultDto.Create("Successfully didn't retrieved meals", null!);
        }, "Error when searching for meals");
    }

    public async Task<GetMealResultDto> GetMealAsync(Guid mealId, string? userEmail)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
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

            var foundMeal = await _mealsRepository.GetByIdAsync(mealId);
            if (foundMeal == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "Meal not found");
            }

            var foundSpoonacularMeal = await _spoonacularApiService.GetSpoonacularMealAsync(foundMeal.SpoonacularId);
            return GetMealResultDto.Create("Successfully retrieved meal",
                GetMealDto.Create(foundSpoonacularMeal, foundMeal.LastPreparedAt, foundMeal.WasPrepared));
        }, "Error when retrieving meal");
    }

    public async Task<SaveMealResultDto> SaveMealAsync(string spoonacularMealId, string? userEmail)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
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

            var foundMeal = await _mealsRepository.FindAsync(m => m.SpoonacularId == spoonacularMealId && m.ProfileId == foundProfile.Id);
            if (foundMeal.Any())
            {
                throw new ServiceException(StatusCodes.Status409Conflict, "You have already saved this meal");
            }

            var foundSpoonacularMeal = await _spoonacularApiService.GetSpoonacularMealAsync(spoonacularMealId);
            if (foundSpoonacularMeal == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, "Spoonacular meal not found");
            }

            var profileId = foundProfile.Id;
            var ingredientsJson = JsonConvert.SerializeObject(foundSpoonacularMeal.ExtendedIngredients);
            var newMeal = _mapper.Map<Meal>(foundSpoonacularMeal, opts =>
            {
                opts.Items["ProfileId"] = profileId;
                opts.Items["IngredientsJson"] = ingredientsJson;
            });

            await _mealsRepository.AddAsync(newMeal);
            return SaveMealResultDto.Create("Successfully saved meal");
        }, "Error when saving meal");
    }

    public async Task<GetAllMealsResultDto> GetMealsAsync(string? userEmail)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
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

            var meals = (await _mealsRepository.GetAllAsync()).Where(m => m.ProfileId == foundProfile.Id)
                .Select(m => _mapper.Map<GetAllMealsMealDto>(m));

            return GetAllMealsResultDto.Create("Successfully retrieved meals", meals);
        }, "Error when retrieving meals");
    }

    public async Task<SetMealPreparedResultDto> SetMealPreparedAsync(Guid mealId, string? userEmail)
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

        var foundMeal = await _mealsRepository.GetByIdAsync(mealId);
        if (foundMeal == null)
        {
            throw new ServiceException(StatusCodes.Status404NotFound, $"Meal with id {mealId} not found");
        }

        if (foundMeal.ProfileId != foundProfile.Id)
        {
            throw new ServiceException(StatusCodes.Status401Unauthorized, "You don't have access to this meal");
        }

        foundMeal.WasPrepared = true;
        foundMeal.LastPreparedAt = DateTime.Now.ToString(CultureInfo.InvariantCulture);
        await _mealsRepository.UpdateAsync(foundMeal, foundMeal.Id);

        return SetMealPreparedResultDto.Create("Successfully set meal to prepared");
    }

    public async Task<DeleteMealResultDto> DeleteMealAsync(Guid mealId, string? userEmail)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
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

            var foundMeal = await _mealsRepository.GetByIdAsync(mealId);
            if (foundMeal == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound, $"Meal with id {mealId} not found");
            }

            if (foundMeal.ProfileId != foundProfile.Id)
            {
                throw new ServiceException(StatusCodes.Status401Unauthorized, "You don't have access to this meal");
            }

            await _mealsRepository.RemoveAsync(foundMeal);

            return DeleteMealResultDto.Create("Successfully deleted meal");
        }, "Error when deleting meal");
    }

    public async Task<GetAllDietaryOptionsResultDto> GetAllDietaryOptionsAsync(string? userEmail)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
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

            var dietaryOptions =
                (await _dietaryOptionRepository.GetAllAsync()).Select(d => _mapper.Map<GetDietaryOptionDto>(d));

            return GetAllDietaryOptionsResultDto.Create("Successfully retrieved dietary options", dietaryOptions);
        }, "Error when retrieving dietary options");
    }

    public async Task<GetAllMealCuisinesResultDto> GetAllMealCuisinesAsync(string? userEmail)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
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

            var mealCuisines =
                (await _mealCuisineRepository.GetAllAsync()).Select(c => _mapper.Map<GetMealCuisineDto>(c));

            return GetAllMealCuisinesResultDto.Create("Successfully retrieved meal cuisines", mealCuisines);
        }, "Error when retrieving meal cuisines");
    }

    public async Task<GetAllMealTypesResultDto> GetAllMealTypesAsync(string? userEmail)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
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

            var mealTypes =
                (await _mealTypeRepository.GetAllAsync()).Select(t => _mapper.Map<GetMealTypeDto>(t));

            return GetAllMealTypesResultDto.Create("Successfully retrieved all meal types", mealTypes);
        }, "Error when retrieving meal types");
    }
}