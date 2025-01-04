using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using MsaCookingApp.DataAccess.Context;
using MsaCookingApp.DataAccess.Entities;
using MsaCookingApp.DataAccess.Exceptions;
using MsaCookingApp.DataAccess.Repositories.Abstractions;

namespace MsaCookingApp.DataAccess.Repositories;

public class UserRepository : Repository<User>, IUserRepository
{
    private readonly ILogger _logger;
    private readonly MsaCookingAppDevContext _context;
    
    public UserRepository(MsaCookingAppDevContext context, ILogger<Repository<User>> logger) : base(context, logger)
    {
        _logger = logger;
        _context = context;
    }


    public async Task UpsertUserAsync(User user)
    {
        try
        {
            if (string.IsNullOrEmpty(user.Email))
            {
                throw new DataAccessException("Error in upsert user in data access layer");
            }
            var foundUser = await _context.Users.FirstOrDefaultAsync((u) => u.Email == user.Email);

            if (foundUser != null)
            {
                foundUser.Email = user.Email;
                foundUser.DisplayName = user.DisplayName;
            }
            else
            {
                _context.Users.Add(user);
            }
            await _context.SaveChangesAsync();
        }
        catch (Exception e)
        {
            _logger.LogError($"Error in upsert user {e}");
            throw;
        }
    }
}