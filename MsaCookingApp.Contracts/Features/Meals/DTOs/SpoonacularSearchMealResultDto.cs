namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SpoonacularSearchMealResultDto
{
    public required IEnumerable<SpoonacularSearchMealResultMealDto> Results { get; set; }
}