namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SetMealPreparedResultDto
{
    public required string Message { get; set; }

    public static SetMealPreparedResultDto Create(string message)
    {
        return new SetMealPreparedResultDto()
        {
            Message = message
        };
    }
}