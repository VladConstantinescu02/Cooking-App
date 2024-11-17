namespace MsaCookingApp.Contracts.Features.Authentication.DTOs;

public class GoogleAuthRequestDto
{
    public required string IdToken { get; set; }
    public required string AccessToken { get; set; }
}