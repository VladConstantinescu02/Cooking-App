namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class DeleteFridgeIngredientResultDto
{
    public required string Message { get; set; }

    public static DeleteFridgeIngredientResultDto Create(string message)
    {
        return new DeleteFridgeIngredientResultDto()
        {
            Message = message
        };
    }
}