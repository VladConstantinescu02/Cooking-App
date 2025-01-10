namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SpoonacularGetMealDto
{
    public required string Id { get; set; }
    public required string Title { get; set; }
    public required double ReadyInMinutes { get; set; }
    public string? Image { get; set; }
    public string? Summary { get; set; }
    public IEnumerable<string>? Cuisines { get; set; }
    public IEnumerable<string>? DishTypes { get; set; }
    public IEnumerable<string>? Diets { get; set; }

    public IEnumerable<SpoonacularGetMealInstructions> AnalyzedInstructions { get; set; } =
        new List<SpoonacularGetMealInstructions>();

    public IEnumerable<SpoonacularGetMealIngredient> ExtendedIngredients { get; set; } =
        new List<SpoonacularGetMealIngredient>();
}