using MsaCookingApp.Contracts.Features.Meals.DTOs;

namespace MsaCookingApp.Contracts.Features.Meals.Abstractions.Services;

public interface IMealsService
{
    Task<SearchMealsResultDto> SearchMealsAsync(SearchMealsDto searchMealsDto, string? userEmail);
}