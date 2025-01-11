using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class CreateProfileResponseDto
{
    private string _message;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public static CreateProfileResponseDto Create(string message)
    {
        return new CreateProfileResponseDto()
        {
            Message = message
        };
    }
}