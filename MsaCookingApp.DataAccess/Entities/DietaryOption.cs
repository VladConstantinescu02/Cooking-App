using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class DietaryOption
{
    [Key]
    public int Id { get; set; }
    [Required]
    public required string Name { get; set; }
}