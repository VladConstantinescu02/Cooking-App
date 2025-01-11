using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetAllMealTypesResultDto
{
    private string _message;
    private IEnumerable<GetMealTypeDto> _mealTypes = new List<GetMealTypeDto>();

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public IEnumerable<GetMealTypeDto> MealTypes
    {
        get => _mealTypes;
        set => _mealTypes = value;
    }

    public static GetAllMealTypesResultDto Create(string message, IEnumerable<GetMealTypeDto> mealTypes)
    {
        return new GetAllMealTypesResultDto()
        {
            Message = message,
            MealTypes = mealTypes
        };
    }
}