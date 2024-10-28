namespace MsaCookingApp.DataAccess.Entities;

public class FridgeIngredient
{
    public required Guid FridgeId { get; set; }
    public required Guid IngredientId { get; set; }
    public required double Quantity { get; set; }

    public virtual required Fridge Fridge { get; set; }
    public virtual required Ingredient Ingredient { get; set; }
}