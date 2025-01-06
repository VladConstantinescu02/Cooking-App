using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class FridgeIngredient
{
    public required Guid FridgeId { get; set; }
    [MaxLength(250)]
    public required string IngredientId { get; set; }
    public required double Quantity { get; set; }
    public required int IngredientMeasuringUnitId { get; set; }

    public virtual Fridge Fridge { get; set; } = null!;
    public virtual Ingredient Ingredient { get; set; } = null!;
    public virtual IngredientMeasuringUnit IngredientMeasuringUnit { get; set; } = null!;

    public static FridgeIngredient Create(Guid fridgeId, string ingredientId, double quantity, int ingredientMeasuringUnitId)
    {
        return new FridgeIngredient()
        {
            FridgeId = fridgeId,
            IngredientId = ingredientId,
            Quantity = quantity,
            IngredientMeasuringUnitId = ingredientMeasuringUnitId
        };
    }
}