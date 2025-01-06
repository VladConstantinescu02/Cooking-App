namespace MsaCookingApp.Contracts.Shared.DTOs;

public class WarningDto
{
    public required string Message { get; set; }

    public static WarningDto Create(string message)
    {
        return new WarningDto()
        {
            Message = message
        };
    }
}