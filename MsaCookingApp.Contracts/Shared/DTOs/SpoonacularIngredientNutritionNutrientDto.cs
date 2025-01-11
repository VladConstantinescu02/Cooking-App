namespace MsaCookingApp.Contracts.Shared.DTOs;

public class SpoonacularIngredientNutritionNutrientDto
{
    private string _name = "";
    private double _amount;
    private string _unit = "";
    private double _percentOfDailyNeeds;

    public string Name
    {
        get => _name;
        set => _name = value;
    }

    public double Amount
    {
        get => _amount;
        set => _amount = value;
    }

    public string Unit
    {
        get => _unit;
        set => _unit = value;
    }

    public double PercentOfDailyNeeds
    {
        get => _percentOfDailyNeeds;
        set => _percentOfDailyNeeds = value;
    }
}