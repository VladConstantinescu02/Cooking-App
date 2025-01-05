using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using MsaCookingApp.Contracts.Shared.Abstractions.Repositories;
using MsaCookingApp.DataAccess.Context;
using MsaCookingApp.DataAccess.Entities;
using MsaCookingApp.DataAccess.Repositories;
using MsaCookingApp.DataAccess.Repositories.Abstractions;

namespace MsaCookingApp.DataAccess;

public static class DependencyInjection
{
    public static IServiceCollection AddDataAccess(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddDbContext<MsaCookingAppDevContext>((options) =>
        {
            options.UseSqlite(configuration.GetConnectionString("MsaCookingAppDevContext"));
        });

        services.AddTransient<IRepository<Ingredient>, Repository<Ingredient>>();
        services.AddTransient<IRepository<Profile>, ProfileRepository>();
        services.AddTransient<IUserRepository, UserRepository>();
        services.AddTransient<IRepository<DietaryOption>, Repository<DietaryOption>>();
        services.AddTransient<IRepository<Fridge>, Repository<Fridge>>();
        return services;
    }
}