namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SaveMealResultDto
{
    public required string Message { get; set; }

    public static SaveMealResultDto Create(string message)
    {
        return new SaveMealResultDto()
        {
            Message = message
        };
    }
}