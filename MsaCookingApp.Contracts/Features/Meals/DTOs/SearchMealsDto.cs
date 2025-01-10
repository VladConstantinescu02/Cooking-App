using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SearchMealsDto
{
    [Required]
    [MaxLength(20)]
    public required string Query { get; set; }
    [Required]
    public int? CuisineId { get; set; }
    [Required]
    public required bool UseProfileDiet { get; set; } = true;
    public int? DietId { get; set; }
    [Required]
    public required bool UseAllFridgeIngredients { get; set; } = false;
    public IEnumerable<string>? Ingredients { get; set; }
    [Required]
    public required int MealTypeId { get; set; }
    public double? MinCalories { get; set; }
    public double? MaxCalories { get; set; }
    [Required]
    public required bool IncludeProfileAlergens { get; set; }
    public IEnumerable<string>? ExcludedProfileAlergens { get; set; }
}