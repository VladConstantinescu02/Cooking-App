namespace MsaCookingApp.Contracts.Features.Test.DTOs;

public class IngredientDto
{
    public Guid Id { get; set; }
    public required string Name { get; set; }
    public required double CaloriesPer100Grams { get; set; }
}