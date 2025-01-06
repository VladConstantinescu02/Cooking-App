using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class ChallengeStatus
{
    [Key]
    public int Id { get; set; }
    [Required]
    [MaxLength(250)]
    public required string Status { get; set; }
}