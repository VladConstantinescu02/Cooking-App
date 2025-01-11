using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class DeleteMealResultDto
{
    private string _message;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public static DeleteMealResultDto Create(string message)
    {
        return new DeleteMealResultDto()
        {
            Message = message
        };
    }
}