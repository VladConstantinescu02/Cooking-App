using System.Net;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using MsaCookingApp.Business.Shared.Exceptions;
using MsaCookingApp.Business.Shared.Settings;
using MsaCookingApp.Contracts.Features.Meals.DTOs;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;
using MsaCookingApp.Contracts.Shared.DTOs;
using Newtonsoft.Json;

namespace MsaCookingApp.Business.Shared.Services;

public class SpoonacularApiService : ISpoonacularApiService
{
    private readonly IHttpClientFactory _httpClientFactory;
    private readonly ApiClientsOptions _apiClientsOptions;
    private readonly SpoonacularOptions _spoonacularOptions;
    private readonly IExceptionHandlingService _exceptionHandlingService;

    public SpoonacularApiService(IHttpClientFactory httpClientFactory, IOptions<ApiClientsOptions> apiClientsOptions, IOptions<SpoonacularOptions> spoonacularOptions, IExceptionHandlingService exceptionHandlingService)
    {
        _httpClientFactory = httpClientFactory;
        _exceptionHandlingService = exceptionHandlingService;
        _spoonacularOptions = spoonacularOptions.Value;
        _apiClientsOptions = apiClientsOptions.Value;
    }

    public async Task<SpoonacularIngredientDto> GetSpoonacularIngredientByIdAsync(string spoonacularIngredientId)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
        {
            var spoonacularApiClientName = _apiClientsOptions.Spoonacular?.Name ?? "";
            var spoonacularApiClient = _httpClientFactory.CreateClient(spoonacularApiClientName);
            var spoonacularApiKey = _spoonacularOptions.ApiKey ?? "";

            var url = $"food/ingredients/{spoonacularIngredientId}/information?apiKey={spoonacularApiKey}&amount=100&unit=grams";

            var response = await spoonacularApiClient.GetAsync(url);
        
            if (!response.IsSuccessStatusCode)
            {
                if (response.StatusCode == HttpStatusCode.NotFound)
                {
                    throw new ServiceException(StatusCodes.Status400BadRequest, $"The ingredient with the id {spoonacularIngredientId} does not exist");    
                }
                throw new ServiceException(StatusCodes.Status500InternalServerError, "Error with the spoonacular api");
            }

            var responseStringContent = await response.Content.ReadAsStringAsync();
            var spoonacularIngredient = JsonConvert.DeserializeObject<SpoonacularIngredientDto>(responseStringContent);

            if (spoonacularIngredient == null)
            {
                throw new ServiceException(StatusCodes.Status500InternalServerError, "Problem when deserializing spoonacular ingredient");
            }

            return spoonacularIngredient;
        }, "Error when retrieving spoonacular ingredient");
    }

    public async Task<SpoonacularIngredientsSearchResultDto?> SearchSpoonacularIngredientsAsync(string query)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
        {
            var spoonacularApiClientName = _apiClientsOptions.Spoonacular?.Name ?? "";
            var spoonacularApiClient = _httpClientFactory.CreateClient(spoonacularApiClientName);
            var spoonacularApiKey = _spoonacularOptions.ApiKey ?? "";
        
            var url = $"food/ingredients/search?apiKey={spoonacularApiKey}&query={query}&addChildren=true";
        
            var response = await spoonacularApiClient.GetAsync(url);
        
            if (!response.IsSuccessStatusCode)
            {
                throw new ServiceException(StatusCodes.Status500InternalServerError, "Error with the spoonacular api");
            }

            var responseStringContent = await response.Content.ReadAsStringAsync();
            var spoonacularIngredientSearchResult =
                JsonConvert.DeserializeObject<SpoonacularIngredientsSearchResultDto>(responseStringContent);
            return spoonacularIngredientSearchResult;
        }, "Error when searching spoonacular ingredient");
    }

    public async Task<SpoonacularSearchMealResultDto?> SearchSpoonacularMealAsync(string query)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
        {
            var spoonacularApiClientName = _apiClientsOptions.Spoonacular?.Name ?? "";
            var spoonacularApiClient = _httpClientFactory.CreateClient(spoonacularApiClientName);
            
            var response = await spoonacularApiClient.GetAsync(query);
        
            if (!response.IsSuccessStatusCode)
            {
                throw new ServiceException(StatusCodes.Status500InternalServerError, "Error with the spoonacular api");
            }

            var responseStringContent = await response.Content.ReadAsStringAsync();
            var spoonacularMealsSearchResult =
                JsonConvert.DeserializeObject<SpoonacularSearchMealResultDto>(responseStringContent);
            return spoonacularMealsSearchResult;
        }, "Error searching meal spoonacular api");
    }
}