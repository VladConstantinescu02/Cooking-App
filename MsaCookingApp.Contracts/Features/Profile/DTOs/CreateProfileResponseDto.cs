namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class CreateProfileResponseDto
{
    public required string Message { get; set; }

    public static CreateProfileResponseDto Create(string message)
    {
        return new CreateProfileResponseDto()
        {
            Message = message
        };
    }
}