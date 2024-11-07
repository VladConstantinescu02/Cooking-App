namespace MsaCookingApp.Business.Shared.Exceptions;

public class ServiceException(int statusCode, string errorMessage) : Exception
{
    public int StatusCode { get; set; } = statusCode;
    public string ErrorMessage { get; set; } = errorMessage;
}