namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetMealResultDto
{
    public required string Message { get; set; }
    public required GetMealDto Meal { get; set; }

    public static GetMealResultDto Create(string message, GetMealDto meal)
    {
        return new GetMealResultDto()
        {
            Message = message,
            Meal = meal
        };
    }
}