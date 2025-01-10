namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetAllMealCuisinesResultDto
{
    public required string Message { get; set; }
    public IEnumerable<GetMealCuisineDto> MealCuisines { get; set; } = new List<GetMealCuisineDto>();

    public static GetAllMealCuisinesResultDto Create(string message, IEnumerable<GetMealCuisineDto> mealCuisines)
    {
        return new GetAllMealCuisinesResultDto()
        {
            Message = message,
            MealCuisines = mealCuisines
        };
    }
}