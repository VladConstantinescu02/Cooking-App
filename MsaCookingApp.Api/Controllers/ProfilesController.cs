using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MsaCookingApp.Api.Filters;
using MsaCookingApp.Api.Helpers;
using MsaCookingApp.Contracts.Features.Profile.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Profile.DTOs;

namespace MsaCookingApp.Api.Controllers;

[Authorize]
[Route("api/profile")]
[ValidateModel]
public class ProfilesController : Controller
{
    private readonly IProfilesService _profilesService;
    public ProfilesController(IProfilesService profilesService)
    {
        _profilesService = profilesService;
    }
    
    [HttpGet]
    public async Task<IActionResult> GetProfileAsync()
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _profilesService.GetProfileAsync(email));
    }

    [HttpPost]
    public async Task<IActionResult> CreateProfileAsync([FromForm] CreateProfileDto createProfileDto)
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _profilesService.CreateProfileAsync(createProfileDto, email));
    }
    
    [HttpDelete]
    public async Task<IActionResult> DeleteProfileAsync()
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _profilesService.DeleteProfileAsync(email));
    }
    
    [HttpPut]
    public async Task<IActionResult> UpdateProfileAsync([FromForm] UpdateProfileDto updateProfileDto)
    {
        var email = AuthorizationHelper.GetUserEmailFromClaims(User);
        return Ok(await _profilesService.UpdateProfileAsync(updateProfileDto, email));
    }

    [HttpGet("search/dietary-option")]
    public async Task<IActionResult> GetSearchDietaryOptionsResultsAsync(string query)
    {
        return Ok(await _profilesService.SearchDietaryOptionAsync(query));
    }
}