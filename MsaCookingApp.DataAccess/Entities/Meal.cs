using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class Meal
{
    [Required]
    public Guid Id { get; set; }
    [Required]
    public required string Name { get; set; }
    [Required]
    public required string RecipeDescription { get; set; }
    [Required]
    public required Guid ProfileId { get; set; }
    [Required]
    public required Guid MealTypeId { get; set; }
    [Required]
    public required double TotalGrams { get; set; }
    [Required]
    public required double TotalCalories { get; set; }
    [Required]
    public required Guid MealCuisineId { get; set; }

    public virtual required Profile Profile { get; set; }
    public virtual required MealType MealType { get; set; }
    public virtual required MealCuisine MealCuisine { get; set; }
    public virtual required ICollection<Ingredient> Ingredients { get; set; }
}