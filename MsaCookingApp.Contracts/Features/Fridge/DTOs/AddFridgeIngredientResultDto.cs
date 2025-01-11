using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class AddFridgeIngredientResultDto
{
    private string _message;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public static AddFridgeIngredientResultDto Create(string message)
    {
        return new AddFridgeIngredientResultDto()
        {
            Message = message
        };
    }
}