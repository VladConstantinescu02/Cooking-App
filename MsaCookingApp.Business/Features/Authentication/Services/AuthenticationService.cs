using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Google.Apis.Auth;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using MsaCookingApp.Business.Shared.Exceptions;
using MsaCookingApp.Business.Shared.Settings;
using MsaCookingApp.Contracts.Features.Authentication.Abstractions;
using MsaCookingApp.Contracts.Features.Authentication.DTOs;
using MsaCookingApp.DataAccess.Entities;
using MsaCookingApp.DataAccess.Exceptions;
using MsaCookingApp.DataAccess.Repositories.Abstractions;

namespace MsaCookingApp.Business.Features.Authentication.Services;

public class AuthenticationService : IAuthenticationService
{
    private readonly JwtOptions _jwtOptions;
    private readonly ILogger _logger;
    private readonly IUserRepository _userRepository;

    public AuthenticationService(IOptions<JwtOptions> jwtOptions, ILogger<AuthenticationService> logger, IUserRepository userRepository)
    {
        _logger = logger;
        _userRepository = userRepository;
        _jwtOptions = jwtOptions.Value;
    }

    public async Task<string> AuthenticateWithGoogleAsync(GoogleAuthRequestDto googleAuthRequestDto)
    {
        try
        {
            var payload = await GoogleJsonWebSignature.ValidateAsync(googleAuthRequestDto.IdToken);
            var claims = new[]
            {
                new Claim(ClaimTypes.Name, payload.Name),
                new Claim(ClaimTypes.Email, payload.Email),
                new Claim(ClaimTypes.NameIdentifier, payload.Subject)
            };

            var jwtSecret = _jwtOptions.Secret ?? "";
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSecret));
            var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var tokenDescriptor = new SecurityTokenDescriptor()
            {
                Subject = new ClaimsIdentity(claims),
                Expires = DateTime.UtcNow.AddHours(3),
                SigningCredentials = credentials
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var jwtToken = tokenHandler.WriteToken(token);

            await _userRepository.UpsertUserAsync(User.Create(payload.Name, payload.Email));

            return jwtToken;
        }
        catch (Exception e)
        {
            _logger.LogError($"Error when authenticating with google {e}");
            if (e is DataAccessException)
            {
                throw new ServiceException(StatusCodes.Status500InternalServerError,
                    $"Data access error in upsert user {e}");
            }
            throw;
        }
    }
}