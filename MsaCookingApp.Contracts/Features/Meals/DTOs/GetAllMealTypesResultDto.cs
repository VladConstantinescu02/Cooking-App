namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetAllMealTypesResultDto
{
    public required string Message { get; set; }
    public IEnumerable<GetMealTypeDto> MealTypes { get; set; } = new List<GetMealTypeDto>();

    public static GetAllMealTypesResultDto Create(string message, IEnumerable<GetMealTypeDto> mealTypes)
    {
        return new GetAllMealTypesResultDto()
        {
            Message = message,
            MealTypes = mealTypes
        };
    }
}