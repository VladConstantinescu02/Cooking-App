namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetAllMealsResultDto
{
    public required string Message { get; set; }
    public IEnumerable<GetAllMealsMealDto> Meals { get; set; } = new List<GetAllMealsMealDto>();

    public static GetAllMealsResultDto Create(string message, IEnumerable<GetAllMealsMealDto> meals)
    {
        return new GetAllMealsResultDto()
        {
            Message = message,
            Meals = meals
        };
    }
}