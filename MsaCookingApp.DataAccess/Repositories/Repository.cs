﻿using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using MsaCookingApp.Contracts.Shared.Abstractions.Repositories;
using MsaCookingApp.DataAccess.Context;

namespace MsaCookingApp.DataAccess.Repositories;

public class Repository<TEntity> : IRepository<TEntity> where TEntity : class
    {
        protected readonly MsaCookingAppDevContext Context;
        protected readonly ILogger Logger;

        public Repository(MsaCookingAppDevContext context, ILogger<Repository<TEntity>> logger)
        {
            Context = context;
            Logger = logger;
        }

        public virtual async Task AddAsync(TEntity item, bool applyChanges = true)
        {
            try
            {
                Context.Set<TEntity>().Add(item);
                if (applyChanges)
                {
                    await SaveChangesAsync();
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                throw;
            }

        }

        public virtual IEnumerable<TEntity> Find(Expression<Func<TEntity, bool>> predicate)
        {
            try
            {
                return Context.Set<TEntity>().Where(predicate);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                throw;
            }
        }

        public virtual async Task<IEnumerable<TEntity>> FindAsync(Expression<Func<TEntity, bool>> predicate)
        {
            try
            {
                return await Context.Set<TEntity>().Where(predicate).ToListAsync();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                throw;
            }
        }

        public virtual async Task<IEnumerable<TEntity>> GetAllAsync()
        {

            try
            {
                return await Context.Set<TEntity>().ToListAsync();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                throw;
            }

        }

        public virtual async Task<TEntity?> GetByIdAsync<TId>(TId id)
        {
            try
            {
                return await Context.Set<TEntity>().FindAsync(id);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                throw;
            }
        }

        public virtual async Task UpdateAsync<TId>(TEntity updatedItem, TId id, bool applyChanges = true)
        {
            try
            {
                var existingItem = await Context.Set<TEntity>().FindAsync(id);

                if (existingItem != null && applyChanges)
                {
                    Context.Entry(existingItem).CurrentValues.SetValues(updatedItem);
                    await SaveChangesAsync();
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                throw;
            }
        }

        public virtual async Task RemoveAsync(TEntity item, bool applyChanges = true)
        {
            try
            {
                Context.Set<TEntity>().Remove(item);
                if (applyChanges)
                {
                    await SaveChangesAsync();
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                throw;
            }
        }

        public virtual async Task RemoveRangeAsync(IEnumerable<TEntity> items, bool applyChanges = true)
        {
            try
            {
                Context.Set<TEntity>().RemoveRange(items);
                if (applyChanges)
                {
                    await SaveChangesAsync();
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                throw;
            }
        }

        protected Task SaveChangesAsync()
        {
            return Context.SaveChangesAsync();
        }
    }