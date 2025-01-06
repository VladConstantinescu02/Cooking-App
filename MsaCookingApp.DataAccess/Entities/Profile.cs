using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class Profile
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    [MaxLength(30)]
    public required string UserName { get; set; }
    [Required]
    [MaxLength(50)]
    public required string FullName { get; set; }
    [MaxLength(256)]
    public string? ProfilePhotoUrl { get; set; }
    [Required]
    public Guid UserId { get; set; }
    public int? DietaryOptionId { get; set; }

    public virtual User User { get; set; } = null!;
    public virtual DietaryOption? DietaryOption { get; set; }
    public virtual ICollection<Challenge> Challenges { get; set; } = new List<Challenge>();

    public virtual ICollection<ChallengeSubmission> ChallengeSubmissionsVoted { get; set; } =
        new List<ChallengeSubmission>();
    public virtual ICollection<Ingredient> IngredientAllergies { get; set; } = new List<Ingredient>();

    public static Profile Create(string userName, string fullName, Guid userId)
    {
        return new Profile()
        {
            UserName = userName,
            FullName = fullName,
            UserId = userId
        };
    }
}