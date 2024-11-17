using MsaCookingApp.Contracts.Features.Authentication.DTOs;

namespace MsaCookingApp.Contracts.Features.Authentication.Abstractions;

public interface IAuthenticationService
{
    Task<string> AuthenticateWithGoogleAsync(GoogleAuthRequestDto googleAuthRequestDto);
}