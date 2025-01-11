using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetAllMealCuisinesResultDto
{
    private string _message;
    private IEnumerable<GetMealCuisineDto> _mealCuisines = new List<GetMealCuisineDto>();

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public IEnumerable<GetMealCuisineDto> MealCuisines
    {
        get => _mealCuisines;
        set => _mealCuisines = value;
    }

    public static GetAllMealCuisinesResultDto Create(string message, IEnumerable<GetMealCuisineDto> mealCuisines)
    {
        return new GetAllMealCuisinesResultDto()
        {
            Message = message,
            MealCuisines = mealCuisines
        };
    }
}