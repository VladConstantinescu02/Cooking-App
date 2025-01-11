using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SearchMealsDto
{
    private string _query;
    private int? _cuisineId;
    private bool _useProfileDiet = true;
    private int? _dietId;
    private bool _useAllFridgeIngredients;
    private IEnumerable<string>? _ingredients;
    private int _mealTypeId;
    private double? _minCalories;
    private double? _maxCalories;
    private bool _includeProfileAlergens;
    private IEnumerable<string>? _excludedProfileAlergens;

    [Required]
    [MaxLength(20)]
    public required string Query
    {
        get => _query;
        [MemberNotNull(nameof(_query))] set => _query = value;
    }

    [Required]
    public int? CuisineId
    {
        get => _cuisineId;
        set => _cuisineId = value;
    }

    [Required]
    public required bool UseProfileDiet
    {
        get => _useProfileDiet;
        set => _useProfileDiet = value;
    }

    public int? DietId
    {
        get => _dietId;
        set => _dietId = value;
    }

    [Required]
    public required bool UseAllFridgeIngredients
    {
        get => _useAllFridgeIngredients;
        set => _useAllFridgeIngredients = value;
    }

    public IEnumerable<string>? Ingredients
    {
        get => _ingredients;
        set => _ingredients = value;
    }

    [Required]
    public required int MealTypeId
    {
        get => _mealTypeId;
        set => _mealTypeId = value;
    }

    public double? MinCalories
    {
        get => _minCalories;
        set => _minCalories = value;
    }

    public double? MaxCalories
    {
        get => _maxCalories;
        set => _maxCalories = value;
    }

    [Required]
    public required bool IncludeProfileAlergens
    {
        get => _includeProfileAlergens;
        set => _includeProfileAlergens = value;
    }

    public IEnumerable<string>? ExcludedProfileAlergens
    {
        get => _excludedProfileAlergens;
        set => _excludedProfileAlergens = value;
    }
}