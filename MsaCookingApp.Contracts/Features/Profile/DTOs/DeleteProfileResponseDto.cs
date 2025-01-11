using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class DeleteProfileResponseDto
{
    private string _message;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public static DeleteProfileResponseDto Create(string message)
    {
        return new DeleteProfileResponseDto()
        {
            Message = message
        };
    }   
}