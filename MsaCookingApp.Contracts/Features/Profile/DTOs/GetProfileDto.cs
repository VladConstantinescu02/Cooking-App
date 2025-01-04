using MsaCookingApp.Contracts.Shared.DTOs;

namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class GetProfileDto
{
    public Guid Id { get; set; }
    public required string UserName { get; set; }
    public required string FullName { get; set; }
    public string? ProfilePhotoUrl { get; set; }
    public required Guid UserId { get; set; }
    public List<ProfileAlergenDto>? Alergens { get; set; }
    public ProfileDietRestricionDto? DietRestriction { get; set; }
    
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