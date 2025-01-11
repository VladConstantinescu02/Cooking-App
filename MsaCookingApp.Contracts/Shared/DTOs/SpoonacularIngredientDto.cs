using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Shared.DTOs;

public class SpoonacularIngredientDto
{
    private string _id = "";
    private string _name;
    private SpoonacularIngredientNutritionDto _nutrition = null!;

    public string Id
    {
        get => _id;
        set => _id = value;
    }

    public required string Name
    {
        get => _name;
        [MemberNotNull(nameof(_name))] set => _name = value;
    }

    public SpoonacularIngredientNutritionDto Nutrition
    {
        get => _nutrition;
        set => _nutrition = value;
    }
}