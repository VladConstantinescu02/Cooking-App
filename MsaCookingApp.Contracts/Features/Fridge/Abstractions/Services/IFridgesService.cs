using MsaCookingApp.Contracts.Features.Fridge.DTOs;

namespace MsaCookingApp.Contracts.Features.Fridge.Abstractions.Services;

public interface IFridgesService
{
    Task<AddFridgeIngredientResultDto> AddFridgeIngredientAsync(AddFridgeIngredientDto addFridgeIngredientDto, string? userEmail);
    Task<UpdateFridgeIngredientResultDto> UpdateFridgeIngredientAsync(UpdateFridgeIngredientDto addFridgeIngredientDto, string? userEmail);
    Task<DeleteFridgeIngredientResultDto> DeleteFridgeIngredientAsync(string fridgeIngredientId, string? userEmail);
    Task<GetFridgeResultDto> GetFridgeAsync(string? userEmail);
    Task<GetIngredientMeasuringUnitsResultDto> GetIngredientMeasuringUnitsAsync();
}