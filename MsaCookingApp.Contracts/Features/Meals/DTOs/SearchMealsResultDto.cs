namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SearchMealsResultDto
{
    public required string Message { get; set; }
    public SpoonacularSearchMealResultDto? Result { get; set; }

    public static SearchMealsResultDto Create(string message, SpoonacularSearchMealResultDto spoonacularSearchMealResultDto)
    {
        return new SearchMealsResultDto()
        {
            Message = message,
            Result = spoonacularSearchMealResultDto
        };
    }
}