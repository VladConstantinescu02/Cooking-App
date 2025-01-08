using System.Text;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using MsaCookingApp.Business.Shared.Exceptions;
using MsaCookingApp.Business.Shared.Settings;
using MsaCookingApp.Contracts.Features.Meals.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Meals.DTOs;
using MsaCookingApp.Contracts.Shared.Abstractions.Repositories;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;
using MsaCookingApp.DataAccess.Entities;
using MsaCookingApp.DataAccess.Repositories.Abstractions;

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

    public MealsService(IExceptionHandlingService exceptionHandlingService, IRepository<DataAccess.Entities.Profile> profileRepository, IUserRepository userRepository, IRepository<DataAccess.Entities.Fridge> fridgeRepository, IOptions<SpoonacularOptions> spoonacularOptions, IRepository<MealCuisine> mealCuisineRepository, IRepository<MealType> mealTypeRepository, IRepository<FridgeIngredient> fridgeIngredientRepository, ISpoonacularApiService spoonacularApiService)
    {
        _exceptionHandlingService = exceptionHandlingService;
        _profileRepository = profileRepository;
        _userRepository = userRepository;
        _fridgeRepository = fridgeRepository;
        _mealCuisineRepository = mealCuisineRepository;
        _mealTypeRepository = mealTypeRepository;
        _fridgeIngredientRepository = fridgeIngredientRepository;
        _spoonacularApiService = spoonacularApiService;
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

            var foundMealCuisine = await _mealCuisineRepository.GetByIdAsync(searchMealsDto.CuisineId);
            if (foundMealCuisine == null)
            {
                throw new ServiceException(StatusCodes.Status404NotFound,
                    $"Meal cuisine with id {searchMealsDto.CuisineId} not found");
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
                    $"/recipes/complexSearch?apiKey={spoonacularApiKey}&query={searchMealsDto.Query}&cuisine={foundMealCuisine.Cuisine}&type={foundMealType.Type}&fillIngredients=true&limitLicense=true");

            var usedDiet = searchMealsDto.Diet;
            if (searchMealsDto.UseProfileDiet)
            {
                usedDiet = foundProfile.DietaryOption?.Name;
            }

            apiQuery.Append($"&diet={usedDiet}");

            if (searchMealsDto.MinCalories != null)
            {
                apiQuery.Append($"&minCalories={searchMealsDto.MinCalories}");
            }

            if (searchMealsDto.MaxCalories != null)
            {
                apiQuery.Append($"&maxCalories={searchMealsDto.MaxCalories}");
            }

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
                apiQuery.Append($"includeIngredients={usedIngredientsCsv.ToString()}");
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
}