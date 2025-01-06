using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class MealCuisine
{
    [Key]
    public int Id { get; set; }
    [Required]
    [MaxLength(250)]
    public required string Cuisine { get; set; }
}