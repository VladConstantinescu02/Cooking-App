using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetAllMealsResultDto
{
    private string _message;
    private IEnumerable<GetAllMealsMealDto> _meals = new List<GetAllMealsMealDto>();

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public IEnumerable<GetAllMealsMealDto> Meals
    {
        get => _meals;
        set => _meals = value;
    }

    public static GetAllMealsResultDto Create(string message, IEnumerable<GetAllMealsMealDto> meals)
    {
        return new GetAllMealsResultDto()
        {
            Message = message,
            Meals = meals
        };
    }
}