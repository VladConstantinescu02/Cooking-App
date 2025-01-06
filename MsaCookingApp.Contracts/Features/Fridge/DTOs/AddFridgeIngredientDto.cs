using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class AddFridgeIngredientDto
{
    [Required]
    public required string IngredientId { get; set; }
    
    [Required]
    [Range(0.0, 10000000)]
    public required double IngredientQuantity { get; set; }

    [Required]
    public required int IngredientMeasuringUnitId { get; set; }

    public static AddFridgeIngredientDto Create(string ingredientId, double ingredientQuantity, int ingredientMeasuringUnitId)
    {
        return new AddFridgeIngredientDto()
        {
            IngredientId = ingredientId,
            IngredientQuantity = ingredientQuantity,
            IngredientMeasuringUnitId = ingredientMeasuringUnitId
        };
    }
}