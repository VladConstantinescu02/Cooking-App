using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class IngredientMeasuringUnit
{
    [Key]
    public int Id { get; set; }
    [Required]
    [MaxLength(250)]
    public required string UnitName { get; set; }
    [Required]
    [MaxLength(5)]
    public required string UnitSuffix { get; set; }
}