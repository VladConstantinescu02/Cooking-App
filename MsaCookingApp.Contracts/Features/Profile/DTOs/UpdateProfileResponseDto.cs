using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class UpdateProfileResponseDto
{
    private string _message;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public static UpdateProfileResponseDto Create(string message)
    {
        return new UpdateProfileResponseDto()
        {
            Message = message
        };
    }
}