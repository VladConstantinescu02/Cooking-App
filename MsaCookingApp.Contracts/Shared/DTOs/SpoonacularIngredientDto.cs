namespace MsaCookingApp.Contracts.Shared.DTOs;

public class SpoonacularIngredientDto
{
    public string Id { get; set; }
    public required string Name { get; set; }
    public SpoonacularIngredientNutritionDto Nutrition { get; set; }
}