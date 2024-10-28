using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class Ingredient
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    public required string Name { get; set; }
    [Required]
    public required double CaloriesPer100Grams { get; set; }
    
    public virtual required ICollection<Meal> Meals { get; set; }
    public virtual required ICollection<Profile> AllergicProfiles { get; set; }
}