using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class WeeklyRanking
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    public required DateTime Day { get; set; }
    [Required]
    public required Guid ChallengeId { get; set; }

    public virtual required Challenge Challenge { get; set; }
}