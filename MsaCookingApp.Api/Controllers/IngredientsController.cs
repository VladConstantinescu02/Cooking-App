using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MsaCookingApp.Contracts.Features.Test.Abstractions.Services;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;

namespace MsaCookingApp.Api.Controllers;

[Authorize]
[Route("/api/ingredients")]
public class IngredientsController : Controller
{
    private readonly ITestService _testService;
    private readonly ISpoonacularApiService _spoonacularApiService;

    public IngredientsController(ITestService testService, ISpoonacularApiService spoonacularApiService)
    {
        _testService = testService;
        _spoonacularApiService = spoonacularApiService;
    }

    [HttpGet]
    public async Task<IActionResult> GetAllIngredientsAsync()
    {
        return Ok(await _testService.GetAllIngredients());
    }

    [HttpGet("search")]
    public async Task<IActionResult> GetSearchSpoonacularIngredientsAsync(string query)
    {
        return Ok(await _spoonacularApiService.SearchSpoonacularIngredientsAsync(query));
    }
}