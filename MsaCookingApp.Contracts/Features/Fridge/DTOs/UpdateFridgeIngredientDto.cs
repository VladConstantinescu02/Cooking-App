using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class UpdateFridgeIngredientDto
{
    [Required]
    public required string IngredientId { get; set; }
    
    [Required]
    [Range(0.0, 10000000)]
    public required double IngredientQuantity { get; set; }

    [Required]
    public required int IngredientMeasuringUnitId { get; set; }

    public static UpdateFridgeIngredientDto Create(string ingredientId, double ingredientQuantity, int ingredientMeasuringUnitId)
    {
        return new UpdateFridgeIngredientDto()
        {
            IngredientId = ingredientId,
            IngredientQuantity = ingredientQuantity,
            IngredientMeasuringUnitId = ingredientMeasuringUnitId
        };
    }
}