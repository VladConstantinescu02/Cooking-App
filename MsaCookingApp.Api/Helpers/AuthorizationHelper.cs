using System.Security.Claims;

namespace MsaCookingApp.Api.Helpers;

public class AuthorizationHelper
{
    public static string GetUserEmailFromClaims(ClaimsPrincipal user)
    {
        return user.Claims.ElementAt(1).Value;
    }
}