using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class IngredientMeasuringUnit
{
    [Key]
    public int Id { get; set; }
    [Required]
    public required string UnitName { get; set; }
}