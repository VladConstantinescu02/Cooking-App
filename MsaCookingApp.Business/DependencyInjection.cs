using Microsoft.Extensions.DependencyInjection;
using MsaCookingApp.Business.Features.Authentication.Services;
using MsaCookingApp.Business.Features.Fridge.Services;
using MsaCookingApp.Business.Features.Meals.Services;
using MsaCookingApp.Business.Features.Profile.Services;
using MsaCookingApp.Business.Features.Test.Services;
using MsaCookingApp.Business.Shared.Services;
using MsaCookingApp.Contracts.Features.Authentication.Abstractions;
using MsaCookingApp.Contracts.Features.Fridge.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Meals.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Profile.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Test.Abstractions.Services;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;

namespace MsaCookingApp.Business;

public static class DependencyInjection
{
    public static IServiceCollection AddBusinessLogic(this IServiceCollection services)
    {
        services.AddAutoMapper(typeof(DependencyInjection));

        services.AddTransient<ITestService, TestService>();
        services.AddTransient<IAuthenticationService, AuthenticationService>();
        services.AddTransient<IProfilesService, ProfilesService>();
        services.AddTransient<ISpoonacularApiService, SpoonacularApiService>();
        services.AddTransient<IFridgesService, FridgesService>();
        services.AddTransient<IExceptionHandlingService, ExceptionHandlingService>();
        services.AddTransient<IMealsService, MealsService>();
        return services;
    }
}