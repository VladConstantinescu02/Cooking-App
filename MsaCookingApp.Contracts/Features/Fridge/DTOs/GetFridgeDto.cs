namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class GetFridgeDto
{
    public required string FridgeName { get; set; }
    public IEnumerable<GetFridgeIngredientDto> FridgeIngredients { get; set; } = new List<GetFridgeIngredientDto>();
    public IEnumerable<string> FridgeAlergensIds { get; set; } = new List<string>();

    public static GetFridgeDto Create(string fridgeName, IEnumerable<GetFridgeIngredientDto> fridgeIngredients, IEnumerable<string> fridgeAlergensIds)
    {
        return new GetFridgeDto()
        {
            FridgeName = fridgeName,
            FridgeIngredients = fridgeIngredients,
            FridgeAlergensIds = fridgeAlergensIds
        };
    }
}