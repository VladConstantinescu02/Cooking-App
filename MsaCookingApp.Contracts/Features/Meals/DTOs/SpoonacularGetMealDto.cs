using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SpoonacularGetMealDto
{
    private string _id;
    private string _title;
    private double _readyInMinutes;
    private string? _image;
    private string? _summary;
    private IEnumerable<string>? _cuisines;
    private IEnumerable<string>? _dishTypes;
    private IEnumerable<string>? _diets;
    private IEnumerable<SpoonacularGetMealInstructions> _analyzedInstructions = new List<SpoonacularGetMealInstructions>();
    private IEnumerable<SpoonacularGetMealIngredient> _extendedIngredients = new List<SpoonacularGetMealIngredient>();

    public required string Id
    {
        get => _id;
        [MemberNotNull(nameof(_id))] set => _id = value;
    }

    public required string Title
    {
        get => _title;
        [MemberNotNull(nameof(_title))] set => _title = value;
    }

    public required double ReadyInMinutes
    {
        get => _readyInMinutes;
        set => _readyInMinutes = value;
    }

    public string? Image
    {
        get => _image;
        set => _image = value;
    }

    public string? Summary
    {
        get => _summary;
        set => _summary = value;
    }

    public IEnumerable<string>? Cuisines
    {
        get => _cuisines;
        set => _cuisines = value;
    }

    public IEnumerable<string>? DishTypes
    {
        get => _dishTypes;
        set => _dishTypes = value;
    }

    public IEnumerable<string>? Diets
    {
        get => _diets;
        set => _diets = value;
    }

    public IEnumerable<SpoonacularGetMealInstructions> AnalyzedInstructions
    {
        get => _analyzedInstructions;
        set => _analyzedInstructions = value;
    }

    public IEnumerable<SpoonacularGetMealIngredient> ExtendedIngredients
    {
        get => _extendedIngredients;
        set => _extendedIngredients = value;
    }
}