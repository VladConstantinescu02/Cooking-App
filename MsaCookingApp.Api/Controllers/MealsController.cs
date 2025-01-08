using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MsaCookingApp.Api.Helpers;
using MsaCookingApp.Contracts.Features.Meals.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Meals.DTOs;

namespace MsaCookingApp.Api.Controllers;

[Authorize]
[Route("/api/meals")]
public class MealsController : Controller
{
    private readonly IMealsService _mealsService;

    public MealsController(IMealsService mealsService)
    {
        _mealsService = mealsService;
    }

    [HttpPost("/search-meal")]
    public async Task<IActionResult> SearchMealsAsync([FromBody] SearchMealsDto searchMealsDto)
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _mealsService.SearchMealsAsync(searchMealsDto, email));
    }
}