using Microsoft.AspNetCore.Mvc;
using MsaCookingApp.Contracts.Features.Authentication.Abstractions;
using MsaCookingApp.Contracts.Features.Authentication.DTOs;

namespace MsaCookingApp.Api.Controllers;

[Route("api/authenticate")]
public class AuthenticationController : Controller
{
    private readonly IAuthenticationService _authenticationService;

    public AuthenticationController(IAuthenticationService authenticationService)
    {
        _authenticationService = authenticationService;
    }

    [HttpPost("google")]
    public async Task<IActionResult> AuthenticateWithGoogleAsync([FromBody] GoogleAuthRequestDto googleAuthRequestDto)
    {
        return Ok(await _authenticationService.AuthenticateWithGoogleAsync(googleAuthRequestDto));
    }
}