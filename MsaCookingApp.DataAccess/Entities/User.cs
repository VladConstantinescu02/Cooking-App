using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class User
{
    [Key] public Guid Id { get; set; }
    [Required]
    [MaxLength(250)]
    public required string DisplayName { get; set; }
    [EmailAddress]
    [MaxLength(250)]
    public required string Email { get; set; }

    public static User Create(string displayName, string email)
    {
        return new User()
        {
            Id = new Guid(),
            DisplayName = displayName,
            Email = email
        };
    }
}