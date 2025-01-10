namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetAllDietaryOptionsResultDto
{
    public required string Message { get; set; }
    public IEnumerable<GetDietaryOptionDto> DietaryOptions { get; set; } = new List<GetDietaryOptionDto>();

    public static GetAllDietaryOptionsResultDto Create(string message, IEnumerable<GetDietaryOptionDto> dietaryOptions)
    {
        return new GetAllDietaryOptionsResultDto()
        {
            Message = message,
            DietaryOptions = dietaryOptions
        };
    }
}