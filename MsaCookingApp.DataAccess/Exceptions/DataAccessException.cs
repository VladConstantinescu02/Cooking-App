namespace MsaCookingApp.DataAccess.Exceptions;

public class DataAccessException(string errorMessage) : Exception
{
    public string ErrorMessage { get; set; } = errorMessage;
}