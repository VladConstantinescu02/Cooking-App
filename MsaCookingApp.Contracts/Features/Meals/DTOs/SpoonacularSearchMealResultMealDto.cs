namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SpoonacularSearchMealResultMealDto
{
    public required string Id { get; set; }
    public required int UsedIngredientCount { get; set; }
    public required int MissedIngredientCount { get; set; }
    public required string Title { get; set; }
    public string? Image { get; set; }
    public IEnumerable<SpoonacularSearchMealIngredientResultDto>? MissedIngredients { get; set; }
    public IEnumerable<SpoonacularSearchMealIngredientResultDto>? UsedIngredients { get; set; }
}