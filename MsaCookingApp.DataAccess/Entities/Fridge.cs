using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class Fridge
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    [MaxLength(250)]
    public required string Name { get; set; }
    [Required]
    public required Guid ProfileId { get; set; }

    public virtual Profile Profile { get; set; } = null!;

    public static Fridge Create(string name, Guid profileId)
    {
        return new Fridge()
        {
            Name = name,
            ProfileId = profileId
        };
    }
}