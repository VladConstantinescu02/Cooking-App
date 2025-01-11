namespace MsaCookingApp.Contracts.Shared.DTOs;

public class SpoonacularIngredientsSearchResultDto
{
    private List<SpoonacularIngredientSearchResultDto> _results = new List<SpoonacularIngredientSearchResultDto>();

    public List<SpoonacularIngredientSearchResultDto> Results
    {
        get => _results;
        set => _results = value;
    }
}