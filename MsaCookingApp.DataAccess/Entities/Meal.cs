using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class Meal
{
    [Required]
    public Guid Id { get; set; }
    [Required]
    [MaxLength(250)]
    public required string Name { get; set; }
    [Required]
    [MaxLength(250)]
    public required string RecipeDescription { get; set; }
    [Required]
    public required Guid ProfileId { get; set; }
    [Required]
    public required int MealTypeId { get; set; }
    [Required]
    public required double TotalGrams { get; set; }
    [Required]
    public required double TotalCalories { get; set; }
    [Required]
    public required int MealCuisineId { get; set; }

    public virtual Profile Profile { get; set; } = null!;
    public virtual MealType MealType { get; set; } = null!;
    public virtual MealCuisine MealCuisine { get; set; } = null!;
    public virtual ICollection<Ingredient> Ingredients { get; set; } = new List<Ingredient>();
}