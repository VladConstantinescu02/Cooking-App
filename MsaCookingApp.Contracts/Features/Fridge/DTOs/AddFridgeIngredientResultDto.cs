namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class AddFridgeIngredientResultDto
{
    public required string Message { get; set; }

    public static AddFridgeIngredientResultDto Create(string message)
    {
        return new AddFridgeIngredientResultDto()
        {
            Message = message
        };
    }
}