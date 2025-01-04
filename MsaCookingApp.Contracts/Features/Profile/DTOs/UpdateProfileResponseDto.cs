namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class UpdateProfileResponseDto
{
    public required string Message { get; set; }

    public static UpdateProfileResponseDto Create(string message)
    {
        return new UpdateProfileResponseDto()
        {
            Message = message
        };
    }
}