using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class MealCuisine
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    public required string Cuisine { get; set; }
}