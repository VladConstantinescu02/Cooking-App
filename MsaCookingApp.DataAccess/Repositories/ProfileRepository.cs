using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using MsaCookingApp.DataAccess.Context;
using MsaCookingApp.DataAccess.Entities;

namespace MsaCookingApp.DataAccess.Repositories;

public class ProfileRepository : Repository<Profile>
{
    public ProfileRepository(MsaCookingAppDevContext context, ILogger<Repository<Profile>> logger) : base(context, logger)
    {
    }

    public override async Task<IEnumerable<Profile>> FindAsync(Expression<Func<Profile, bool>> predicate)
    {
        try
        {
            return await Context.Profiles.Include(p => p.DietaryOption).Include(p => p.IngredientAllergies)
                .Where(predicate).ToListAsync();
        }
        catch (Exception ex)
        {
            Logger.LogError(ex.ToString());
            throw;
        }
    }
}