using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MsaCookingApp.DataAccess.Entities;

public class Profile
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    public required string UserName { get; set; }
    [Required]
    public required string FullName { get; set; }
    public string? ProfilePhotoUrl { get; set; }
    [Required]
    public Guid UserId { get; set; }
    [Required]
    public int? DietaryOptionId { get; set; }

    public virtual required User User { get; set; }
    public virtual DietaryOption? DietaryOption { get; set; }
    public virtual required ICollection<Challenge> Challenges { get; set; }
    public virtual required ICollection<ChallengeSubmission> ChallengeSubmissionsVoted { get; set; }
    public virtual required ICollection<Ingredient> IngredientAllergies { get; set; }
}