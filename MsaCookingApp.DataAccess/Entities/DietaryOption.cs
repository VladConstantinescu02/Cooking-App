using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class DietaryOption
{
    [Key]
    public int Id { get; set; }
    [Required]
    [MaxLength(250)]
    public required string Name { get; set; }

    public static DietaryOption Create(string name)
    {
        return new DietaryOption()
        {
            Name = name
        };
    }
}