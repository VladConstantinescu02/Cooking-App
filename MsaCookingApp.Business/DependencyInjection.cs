using Microsoft.Extensions.DependencyInjection;
using MsaCookingApp.Business.Features.Authentication.Services;
using MsaCookingApp.Business.Features.Test.Services;
using MsaCookingApp.Contracts.Features.Authentication.Abstractions;
using MsaCookingApp.Contracts.Features.Test.Abstractions.Services;

namespace MsaCookingApp.Business;

public static class DependencyInjection
{
    public static IServiceCollection AddBusinessLogic(this IServiceCollection services)
    {
        services.AddAutoMapper(typeof(MsaCookingApp.Business.DependencyInjection));

        services.AddTransient<ITestService, TestService>();
        services.AddTransient<IAuthenticationService, AuthenticationService>();
        return services;
    }
}