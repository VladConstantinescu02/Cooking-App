namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class GetProfileResponseDto
{
    public required string Message { get; set; }
    public required GetProfileDto Profile { get; set; }

    public static GetProfileResponseDto Create(string message, GetProfileDto profile)
    {
        return new GetProfileResponseDto()
        {
            Message = message,
            Profile = profile
        };
    }
}