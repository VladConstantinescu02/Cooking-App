using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class User
{
    [Key]
    public Guid Id { get; set; }
    [Required]
    public required string Name { get; set; }
    [EmailAddress]
    public required string Email { get; set; }
}