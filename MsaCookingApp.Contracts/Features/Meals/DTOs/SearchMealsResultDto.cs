using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SearchMealsResultDto
{
    private string _message;
    private SpoonacularSearchMealResultDto? _result;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public SpoonacularSearchMealResultDto? Result
    {
        get => _result;
        set => _result = value;
    }

    public static SearchMealsResultDto Create(string message, SpoonacularSearchMealResultDto spoonacularSearchMealResultDto)
    {
        return new SearchMealsResultDto()
        {
            Message = message,
            Result = spoonacularSearchMealResultDto
        };
    }
}