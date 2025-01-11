using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class DeleteFridgeIngredientResultDto
{
    private string _message;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public static DeleteFridgeIngredientResultDto Create(string message)
    {
        return new DeleteFridgeIngredientResultDto()
        {
            Message = message
        };
    }
}