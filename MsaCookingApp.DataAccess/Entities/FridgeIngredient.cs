namespace MsaCookingApp.DataAccess.Entities;

public class FridgeIngredient
{
    public required Guid FridgeId { get; set; }
    public required Guid IngredientId { get; set; }
    public required double Quantity { get; set; }
    public required int IngredientMeasuringUnitId { get; set; }

    public virtual Fridge Fridge { get; set; }
    public virtual Ingredient Ingredient { get; set; }
    public virtual IngredientMeasuringUnit IngredientMeasuringUnit { get; set; }
}