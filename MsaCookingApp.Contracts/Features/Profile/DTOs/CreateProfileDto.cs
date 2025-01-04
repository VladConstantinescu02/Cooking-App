using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class CreateProfileDto
{
    [Required]
    [MaxLength(30)]
    public required string UserName { get; set; }
    
    [MaxLength(256)]
    public string? ProfilePhotoUrl { get; set; }

    public IEnumerable<string>? IngredientAllergies { get; set; }

    public int? DietaryOptionId { get; set; }

    public string? NewDietaryOption { get; set; }
}