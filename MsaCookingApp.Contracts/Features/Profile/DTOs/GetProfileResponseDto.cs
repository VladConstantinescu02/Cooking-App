using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class GetProfileResponseDto
{
    private string _message;
    private GetProfileDto _profile;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public required GetProfileDto Profile
    {
        get => _profile;
        [MemberNotNull(nameof(_profile))] set => _profile = value;
    }

    public static GetProfileResponseDto Create(string message, GetProfileDto profile)
    {
        return new GetProfileResponseDto()
        {
            Message = message,
            Profile = profile
        };
    }
}