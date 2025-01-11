using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class GetFridgeDto
{
    private string _fridgeName;
    private IEnumerable<GetFridgeIngredientDto> _fridgeIngredients = new List<GetFridgeIngredientDto>();
    private IEnumerable<string> _fridgeAlergensIds = new List<string>();

    public required string FridgeName
    {
        get => _fridgeName;
        [MemberNotNull(nameof(_fridgeName))] set => _fridgeName = value;
    }

    public IEnumerable<GetFridgeIngredientDto> FridgeIngredients
    {
        get => _fridgeIngredients;
        set => _fridgeIngredients = value;
    }

    public IEnumerable<string> FridgeAlergensIds
    {
        get => _fridgeAlergensIds;
        set => _fridgeAlergensIds = value;
    }

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