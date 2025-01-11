using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetMealResultDto
{
    private string _message;
    private GetMealDto _meal;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public required GetMealDto Meal
    {
        get => _meal;
        [MemberNotNull(nameof(_meal))] set => _meal = value;
    }

    public static GetMealResultDto Create(string message, GetMealDto meal)
    {
        return new GetMealResultDto()
        {
            Message = message,
            Meal = meal
        };
    }
}