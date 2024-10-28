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
    public required string PhotoUrl { get; set; }
    [Required]
    public required string Description { get; set; }

    public virtual required Challenge Challenge { get; set; }
    public virtual required Profile Profile { get; set; }
    public virtual required ICollection<Profile> ProfilesThatVoted { get; set; }
}