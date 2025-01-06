using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class MealType
{
    [Key]
    public int Id { get; set; }
    [Required]
    [MaxLength(250)]
    public required string Type { get; set; }
}