namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetMealTypeDto
{
    public int Id { get; set; }
    public required string Type { get; set; }
}