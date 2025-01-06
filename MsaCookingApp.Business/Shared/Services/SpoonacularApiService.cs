﻿using System.Net;
using System.Net.Http.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using MsaCookingApp.Business.Shared.Exceptions;
using MsaCookingApp.Business.Shared.Settings;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;
using MsaCookingApp.Contracts.Shared.DTOs;
using Newtonsoft.Json;

namespace MsaCookingApp.Business.Shared.Services;

public class SpoonacularApiService : ISpoonacularApiService
{
    private readonly IHttpClientFactory _httpClientFactory;
    private readonly ApiClientsOptions _apiClientsOptions;
    private readonly SpoonacularOptions _spoonacularOptions;

    public SpoonacularApiService(IHttpClientFactory httpClientFactory, IOptions<ApiClientsOptions> apiClientsOptions, IOptions<SpoonacularOptions> spoonacularOptions)
    {
        _httpClientFactory = httpClientFactory;
        _spoonacularOptions = spoonacularOptions.Value;
        _apiClientsOptions = apiClientsOptions.Value;
    }

    public async Task<SpoonacularIngredientDto> GetSpoonacularIngredientByIdAsync(string spoonacularIngredientId)
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
    }

    public async Task<SpoonacularIngredientsSearchResultDto?> SearchSpoonacularIngredientsAsync(string query)
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
    }
}