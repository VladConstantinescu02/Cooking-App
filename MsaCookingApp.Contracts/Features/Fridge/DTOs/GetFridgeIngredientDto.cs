namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class GetFridgeIngredientDto
{
    public string IngredientId { get; set; } = "";
    public required string Name { get; set; }
    public required double CaloriesPer100Grams { get; set; }
    public required double Quantity { get; set; }
    public required string IngredientMeasuringUnitSuffix { get; set; }

    public static GetFridgeIngredientDto Create(string ingredientId, string name, double caloriesPer100Grams,
        double quantity, string ingredientMeasuringUnitSuffix)
    {
        return new GetFridgeIngredientDto()
        {
            IngredientId = ingredientId,
            Name = name,
            CaloriesPer100Grams = caloriesPer100Grams,
            Quantity = quantity,
            IngredientMeasuringUnitSuffix = ingredientMeasuringUnitSuffix
        };
    }
}