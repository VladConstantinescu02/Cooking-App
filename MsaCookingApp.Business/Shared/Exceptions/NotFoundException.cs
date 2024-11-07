using Microsoft.AspNetCore.Http;

namespace MsaCookingApp.Business.Shared.Exceptions;

public class NotFoundException(string message) : ServiceException(StatusCodes.Status404NotFound, message) { }