using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MsaCookingApp.Api.Helpers;
using MsaCookingApp.Contracts.Features.Fridge.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Fridge.DTOs;

namespace MsaCookingApp.Api.Controllers;

[Authorize]
[Route("/api/fridge")]
public class FridgesController : Controller
{
    private readonly IFridgesService _fridgesService;

    public FridgesController(IFridgesService fridgesService)
    {
        _fridgesService = fridgesService;
    }
    
    [HttpGet]
    public async Task<IActionResult> GetFridgeAsync()
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _fridgesService.GetFridgeAsync(email));
    }
    
    [HttpGet("ingredients/measuring-units")]
    public async Task<IActionResult> GetIngredientMeasuringUnitsAsync()
    {
        return Ok(await _fridgesService.GetIngredientMeasuringUnitsAsync());
    }

    [HttpPost("ingredient")]
    public async Task<IActionResult> AddFridgeIngredientAsync([FromBody] AddFridgeIngredientDto addFridgeIngredientDto)
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _fridgesService.AddFridgeIngredientAsync(addFridgeIngredientDto, email));
    }
    
    [HttpPut("ingredient")]
    public async Task<IActionResult> UpdateFridgeIngredientAsync([FromBody] UpdateFridgeIngredientDto updateFridgeIngredientDto)
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _fridgesService.UpdateFridgeIngredientAsync(updateFridgeIngredientDto, email));
    }
    
    [HttpDelete("ingredient")]
    public async Task<IActionResult> DeleteFridgeIngredientAsync(string fridgeIngredientId)
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _fridgesService.DeleteFridgeIngredientAsync(fridgeIngredientId, email));
    }
}