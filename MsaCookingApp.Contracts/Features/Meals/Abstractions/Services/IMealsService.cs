using MsaCookingApp.Contracts.Features.Meals.DTOs;

namespace MsaCookingApp.Contracts.Features.Meals.Abstractions.Services;

public interface IMealsService
{
    Task<SearchMealsResultDto> SearchMealsAsync(SearchMealsDto searchMealsDto, string? userEmail);
    Task<GetMealResultDto> GetMealAsync(Guid mealId, string? userEmail);
    Task<SaveMealResultDto> SaveMealAsync(string spoonacularMealId, string? userEmail);
    Task<GetAllMealsResultDto> GetMealsAsync(string? userEmail);
    Task<SetMealPreparedResultDto> SetMealPreparedAsync(Guid mealId, string? userEmail);
    Task<DeleteMealResultDto> DeleteMealAsync(Guid mealId, string? userEmail);
    Task<GetAllDietaryOptionsResultDto> GetAllDietaryOptionsAsync(string? userEmail);
    Task<GetAllMealCuisinesResultDto> GetAllMealCuisinesAsync(string? userEmail);
    Task<GetAllMealTypesResultDto> GetAllMealTypesAsync(string? userEmail);
}