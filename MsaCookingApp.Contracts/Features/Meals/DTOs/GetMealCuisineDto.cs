namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetMealCuisineDto
{
    public int Id { get; set; }
    public required string Cuisine { get; set; }   
}