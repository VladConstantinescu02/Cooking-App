namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class DeleteMealResultDto
{
    public required string Message { get; set; }

    public static DeleteMealResultDto Create(string message)
    {
        return new DeleteMealResultDto()
        {
            Message = message
        };
    }
}