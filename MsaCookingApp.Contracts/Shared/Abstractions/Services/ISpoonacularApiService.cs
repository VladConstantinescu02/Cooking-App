using MsaCookingApp.Contracts.Features.Meals.DTOs;
using MsaCookingApp.Contracts.Shared.DTOs;

namespace MsaCookingApp.Contracts.Shared.Abstractions.Services;

public interface ISpoonacularApiService
{
    Task<SpoonacularIngredientDto> GetSpoonacularIngredientByIdAsync(string spoonacularIngredientId);
    Task<SpoonacularIngredientsSearchResultDto?> SearchSpoonacularIngredientsAsync(string query);
    Task<SpoonacularSearchMealResultDto?> SearchSpoonacularMealAsync(string query);
}