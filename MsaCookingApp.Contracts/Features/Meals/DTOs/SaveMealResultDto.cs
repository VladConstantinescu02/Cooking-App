using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SaveMealResultDto
{
    private string _message;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public static SaveMealResultDto Create(string message)
    {
        return new SaveMealResultDto()
        {
            Message = message
        };
    }
}