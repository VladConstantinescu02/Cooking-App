namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class DeleteProfileResponseDto
{
    public required string Message { get; set; }

    public static DeleteProfileResponseDto Create(string message)
    {
        return new DeleteProfileResponseDto()
        {
            Message = message
        };
    }   
}