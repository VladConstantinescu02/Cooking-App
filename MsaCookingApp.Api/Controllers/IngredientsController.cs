using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;

namespace MsaCookingApp.Api.Controllers;

[Authorize]
[Route("/api/ingredients")]
public class IngredientsController : Controller
{
    private readonly ISpoonacularApiService _spoonacularApiService;

    public IngredientsController(ISpoonacularApiService spoonacularApiService)
    {
        _spoonacularApiService = spoonacularApiService;
    }

    [HttpGet("search")]
    public async Task<IActionResult> GetSearchSpoonacularIngredientsAsync(string query)
    {
        return Ok(await _spoonacularApiService.SearchSpoonacularIngredientsAsync(query));
    }
}