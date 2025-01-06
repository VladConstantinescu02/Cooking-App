using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using MsaCookingApp.DataAccess.Context;
using MsaCookingApp.DataAccess.Entities;

namespace MsaCookingApp.DataAccess.Repositories;

public class FridgeIngredientRepository : Repository<FridgeIngredient>
{
    public FridgeIngredientRepository(MsaCookingAppDevContext context, ILogger<Repository<FridgeIngredient>> logger) : base(context, logger)
    {
    }

    public override async Task<IEnumerable<FridgeIngredient>> GetAllAsync()
    {
        try
        {
            return await Context.FridgeIngredients.Include(fi => fi.Ingredient)
                .Include(fi => fi.IngredientMeasuringUnit).ToListAsync();
        }
        catch (Exception ex)
        {
            Logger.LogError(ex.ToString());
            throw;
        }
    }
}