namespace MsaCookingApp.Contracts.Shared.DTOs;

public class SpoonacularIngredientNutritionDto
{
    private List<SpoonacularIngredientNutritionNutrientDto> _nutrients = new List<SpoonacularIngredientNutritionNutrientDto>();

    public List<SpoonacularIngredientNutritionNutrientDto> Nutrients
    {
        get => _nutrients;
        set => _nutrients = value;
    }
}