using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class Challenge
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    public required string Prompt { get; set; }
    [Required]
    public required DateTime Day { get; set; }
    [Required]
    public required int ChallengeStatusId { get; set; }
    public string? PhotoUrl { get; set; }

    public virtual required ChallengeStatus ChallengeStatus { get; set; }
    public virtual required ICollection<Profile> ParticipantProfiles { get; set; }
}