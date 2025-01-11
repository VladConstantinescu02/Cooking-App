using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SetMealPreparedResultDto
{
    private string _message;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public static SetMealPreparedResultDto Create(string message)
    {
        return new SetMealPreparedResultDto()
        {
            Message = message
        };
    }
}