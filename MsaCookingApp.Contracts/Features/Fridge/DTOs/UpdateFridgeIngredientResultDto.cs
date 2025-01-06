namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class UpdateFridgeIngredientResultDto
{
    public required string Message { get; set; }

    public static UpdateFridgeIngredientResultDto Create(string message)
    {
        return new UpdateFridgeIngredientResultDto()
        {
            Message = message
        };
    }
}