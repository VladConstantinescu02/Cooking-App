﻿using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using MsaCookingApp.Contracts.Shared.Abstractions.Repositories;
using MsaCookingApp.DataAccess.Context;
using MsaCookingApp.DataAccess.Entities;
using MsaCookingApp.DataAccess.Repositories;

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
        return services;
    }
}