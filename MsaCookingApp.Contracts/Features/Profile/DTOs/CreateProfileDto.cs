using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;
using Microsoft.AspNetCore.Http;

namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class CreateProfileDto
{
    private string _userName;
    private IEnumerable<string>? _ingredientAllergies;
    private int? _dietaryOptionId;
    private string? _newDietaryOption;
    private IFormFile? _profilePhoto;

    [Required]
    [MaxLength(30)]
    public required string UserName
    {
        get => _userName;
        [MemberNotNull(nameof(_userName))] set => _userName = value;
    }

    public IFormFile? ProfilePhoto
    {
        get => _profilePhoto;
        set => _profilePhoto = value;
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