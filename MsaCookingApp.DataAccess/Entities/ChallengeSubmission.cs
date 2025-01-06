using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class ChallengeSubmission
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    public required Guid ChallengeId { get; set; }
    [Required]
    public required Guid ParticipantProfileId { get; set; }
    [Required]
    [MaxLength(250)]
    public required string PhotoUrl { get; set; }
    [Required]
    [MaxLength(250)]
    public required string Description { get; set; }

    public virtual Challenge Challenge { get; set; } = null!;
    public virtual Profile Profile { get; set; } = null!;
    public virtual ICollection<Profile> ProfilesThatVoted { get; set; } = new List<Profile>();
}