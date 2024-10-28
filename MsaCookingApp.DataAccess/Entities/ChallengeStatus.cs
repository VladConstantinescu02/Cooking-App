using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class ChallengeStatus
{
    [Key]
    public int Id { get; set; }
    [Required]
    public required string Status { get; set; }
}