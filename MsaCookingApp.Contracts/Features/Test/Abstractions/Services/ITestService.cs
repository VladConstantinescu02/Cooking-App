using MsaCookingApp.Contracts.Features.Test.DTOs;

namespace MsaCookingApp.Contracts.Features.Test.Abstractions.Services;

public interface ITestService
{
    public Task<IEnumerable<IngredientDto>> GetAllIngredients();
}