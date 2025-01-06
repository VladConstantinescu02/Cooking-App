using Microsoft.Extensions.Logging;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;

namespace MsaCookingApp.Business.Shared.Services;

public class ExceptionHandlingService : IExceptionHandlingService
{
    private readonly ILogger<ExceptionHandlingService> _logger;

    public ExceptionHandlingService(ILogger<ExceptionHandlingService> logger)
    {
        _logger = logger;
    }

    public async Task<T> ExecuteWithExceptionHandlingAsync<T>(Func<Task<T>> action, string errorMessage)
    {
        try
        {
            return await action();
        }
        catch (Exception e)
        {
            _logger.LogError($"{errorMessage}: {e}");
            throw;
        }
    }

    public async Task ExecuteWithExceptionHandlingAsync(Func<Task> action, string errorMessage)
    {
        try
        {
            await action();
        }
        catch (Exception e)
        {
            _logger.LogError($"{errorMessage}: {e}");
            throw;
        }
    }
}