using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class Challenge
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    [MaxLength(250)]
    public required string Prompt { get; set; }
    [Required]
    public required DateTime Day { get; set; }
    [Required]
    public required int ChallengeStatusId { get; set; }
    [MaxLength(250)]
    public string? PhotoUrl { get; set; }

    public virtual ChallengeStatus ChallengeStatus { get; set; } = null!;
    public virtual ICollection<Profile> ParticipantProfiles { get; set; } = new List<Profile>();
}