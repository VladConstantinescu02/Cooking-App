namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetAllMealsMealDto
{
    public required string Id { get; set; }
    public required string Name { get; set; }
    public required string Summary { get; set; }
    public required double ReadyInMinutes { get; set; }
    public string? Image { get; set; }
    public string? LastPreparedAt { get; set; }
    public required bool WasPrepared { get; set; }
    public required Guid ProfileId { get; set; }
    public string? IngredientsJson { get; set; }
}