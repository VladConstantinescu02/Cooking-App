namespace MsaCookingApp.Contracts.Shared.Abstractions.Services;

public interface IExceptionHandlingService
{
    Task<T> ExecuteWithExceptionHandlingAsync<T>(Func<Task<T>> action, string errorMessage);
    Task ExecuteWithExceptionHandlingAsync(Func<Task> action, string errorMessage);
}