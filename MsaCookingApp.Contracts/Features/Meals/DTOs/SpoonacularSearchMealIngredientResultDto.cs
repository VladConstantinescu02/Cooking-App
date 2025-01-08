namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SpoonacularSearchMealIngredientResultDto
{
    public required string Id { get; set; }
    public required double Amount { get; set; }
    public string? Unit { get; set; }
    public string? UnitShort { get; set; }
    public required string Name { get; set; }
    public string? Image { get; set; }
}