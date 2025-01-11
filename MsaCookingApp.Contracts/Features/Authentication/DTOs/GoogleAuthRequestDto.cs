namespace MsaCookingApp.Contracts.Features.Authentication.DTOs;

public class GoogleAuthRequestDto
{
    public GoogleAuthRequestDto(string idToken)
    {
        IdToken = idToken;
    }

    public string IdToken { get; set; }
}