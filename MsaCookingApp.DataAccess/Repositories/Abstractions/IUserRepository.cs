using MsaCookingApp.DataAccess.Entities;

namespace MsaCookingApp.DataAccess.Repositories.Abstractions;

public interface IUserRepository : IRepository<User>
{
    Task UpsertUserAsync(User user);
}