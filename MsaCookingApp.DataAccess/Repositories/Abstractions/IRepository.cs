using System.Linq.Expressions;

namespace MsaCookingApp.Contracts.Shared.Abstractions.Repositories;

public interface IRepository<TEntity>
{
    Task AddAsync(TEntity item, bool applyChanges = true);
    Task<TEntity?> AddAndReturnEntityAsync(TEntity item);
    Task UpdateAsync<TId>(TEntity updatedItem, TId id, bool applyChanges = true);
    Task RemoveAsync(TEntity item, bool applyChanges = true);
    Task RemoveRangeAsync(IEnumerable<TEntity> items, bool applyChanges = true);
    Task<IEnumerable<TEntity>> GetAllAsync();
    IEnumerable<TEntity> Find(Expression<Func<TEntity, bool>> predicate);
    Task<IEnumerable<TEntity>> FindAsync(Expression<Func<TEntity, bool>> predicate);
    Task<TEntity?> GetByIdAsync<TId>(TId id);
}