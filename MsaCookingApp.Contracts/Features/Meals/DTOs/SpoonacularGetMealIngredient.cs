namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SpoonacularGetMealIngredient
{
    public required string Id { get; set; }
    public required string Name { get; set; }
    public string? Original { get; set; }
    public double? Amount { get; set; }
    public string? Unit { get; set; }
}