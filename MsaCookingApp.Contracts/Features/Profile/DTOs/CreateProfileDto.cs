using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class CreateProfileDto
{
    private string _userName;
    private string? _profilePhotoUrl;
    private IEnumerable<string>? _ingredientAllergies;
    private int? _dietaryOptionId;
    private string? _newDietaryOption;

    [Required]
    [MaxLength(30)]
    public required string UserName
    {
        get => _userName;
        [MemberNotNull(nameof(_userName))] set => _userName = value;
    }

    [MaxLength(256)]
    public string? ProfilePhotoUrl
    {
        get => _profilePhotoUrl;
        set => _profilePhotoUrl = value;
    }

    public IEnumerable<string>? IngredientAllergies
    {
        get => _ingredientAllergies;
        set => _ingredientAllergies = value;
    }

    public int? DietaryOptionId
    {
        get => _dietaryOptionId;
        set => _dietaryOptionId = value;
    }

    public string? NewDietaryOption
    {
        get => _newDietaryOption;
        set => _newDietaryOption = value;
    }
}