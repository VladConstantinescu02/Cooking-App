using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using MsaCookingApp.Business.Shared.Exceptions;

namespace MsaCookingApp.Api.Controllers;

[Route("error")]
[ApiExplorerSettings(IgnoreApi = true)]
public class ErrorsController : Controller
{
    [HttpGet]
    public IActionResult Index()
    {
        var exceptionFeature = HttpContext.Features.Get<IExceptionHandlerFeature>();
        if (exceptionFeature is null) return Problem();

        var exception = exceptionFeature.Error;

        if (exception is ServiceException serviceException)
        {
            return Problem(statusCode: serviceException.StatusCode, detail: serviceException.ErrorMessage);
        }

        return Problem();
    }
}