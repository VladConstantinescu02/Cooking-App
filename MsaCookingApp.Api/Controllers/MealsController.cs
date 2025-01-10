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
    
    [HttpGet]
    public async Task<IActionResult> SearchMealsAsync(Guid mealId)
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _mealsService.GetMealAsync(mealId, email));
    }
    
    [HttpPost]
    public async Task<IActionResult> SaveMealAsync(string spoonacularMealId)
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _mealsService.SaveMealAsync(spoonacularMealId, email));
    }
    
    [HttpGet("all")]
    public async Task<IActionResult> GetMealsAsync()
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _mealsService.GetMealsAsync(email));
    }
    
    [HttpPatch("set-meal-prepared")]
    public async Task<IActionResult> SetMealPreparedAsync(Guid mealId)
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _mealsService.SetMealPreparedAsync(mealId, email));
    }
    
    [HttpDelete]
    public async Task<IActionResult> DeleteMealAsync(Guid mealId)
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _mealsService.DeleteMealAsync(mealId, email));
    }
    
    [HttpGet("dietary-options")]
    public async Task<IActionResult> GetAllDietaryOptionsAsync()
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _mealsService.GetAllDietaryOptionsAsync(email));
    }
    
    [HttpGet("meal-cuisines")]
    public async Task<IActionResult> GetAllMealCuisinesAsync()
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _mealsService.GetAllMealCuisinesAsync(email));
    }
    
    [HttpGet("meal-types")]
    public async Task<IActionResult> GetAllMealTypesAsync()
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _mealsService.GetAllMealTypesAsync(email));
    }
}