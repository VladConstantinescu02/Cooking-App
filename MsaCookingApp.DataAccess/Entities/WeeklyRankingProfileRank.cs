using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class WeeklyRankingProfileRank
{
    [Required]
    public required Guid WeeklyRankingId { get; set; }
    [Required]
    public required Guid ProfileId { get; set; }
    [Required]
    public required int Rank { get; set; }

    public virtual WeeklyRanking WeeklyRanking { get; set; } = null!;
    public virtual Profile Profile { get; set; } = null!;
}