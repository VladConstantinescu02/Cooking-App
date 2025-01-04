namespace MsaCookingApp.Contracts.Shared.DTOs;

public class SpoonacularIngredientNutritionNutrientDto
{
    public string Name { get; set; }
    public double Amount { get; set; }
    public string Unit { get; set; }
    public double PercentOfDailyNeeds { get; set; }
}