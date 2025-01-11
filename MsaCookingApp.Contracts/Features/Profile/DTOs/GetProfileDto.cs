using System.Diagnostics.CodeAnalysis;
using MsaCookingApp.Contracts.Shared.DTOs;

namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class GetProfileDto
{
    private Guid _id;
    private string _userName;
    private string _fullName;
    private string? _profilePhotoUrl;
    private Guid _userId;
    private List<ProfileAlergenDto>? _alergens;
    private ProfileDietRestricionDto? _dietRestriction;

    public Guid Id
    {
        get => _id;
        set => _id = value;
    }

    public required string UserName
    {
        get => _userName;
        [MemberNotNull(nameof(_userName))] set => _userName = value;
    }

    public required string FullName
    {
        get => _fullName;
        [MemberNotNull(nameof(_fullName))] set => _fullName = value;
    }

    public string? ProfilePhotoUrl
    {
        get => _profilePhotoUrl;
        set => _profilePhotoUrl = value;
    }

    public required Guid UserId
    {
        get => _userId;
        set => _userId = value;
    }

    public List<ProfileAlergenDto>? Alergens
    {
        get => _alergens;
        set => _alergens = value;
    }

    public ProfileDietRestricionDto? DietRestriction
    {
        get => _dietRestriction;
        set => _dietRestriction = value;
    }

    public static GetProfileDto Create(
        Guid id,
        string userName,
        string fullName,
        Guid userId,
        string? profilePhotoUrl = null,
        List<ProfileAlergenDto>? alergens = null,
        ProfileDietRestricionDto? dietRestriction = null)
    {
        return new GetProfileDto
        {
            Id = id,
            UserName = userName,
            FullName = fullName,
            UserId = userId,
            ProfilePhotoUrl = profilePhotoUrl,
            Alergens = alergens ?? new List<ProfileAlergenDto>(),
            DietRestriction = dietRestriction
        };
    }
}