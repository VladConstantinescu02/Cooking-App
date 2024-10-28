using Microsoft.AspNetCore.Mvc;
using MsaCookingApp.Contracts.Features.Test.Abstractions.Services;

namespace MsaCookingApp.Api.Controllers;

[Route("/api/ingredients")]
public class IngredientsController : Controller
{
    private readonly ITestService _testService;

    public IngredientsController(ITestService testService)
    {
        _testService = testService;
    }

    [HttpGet]
    public async Task<IActionResult> GetAllIngredientsAsync()
    {
        return Ok(await _testService.GetAllIngredients());
    }
}