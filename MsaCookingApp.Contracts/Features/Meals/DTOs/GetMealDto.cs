using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetMealDto
{
    private SpoonacularGetMealDto? _meal;
    private string? _lastPreparedAt;
    private bool _wasPrepared;

    public SpoonacularGetMealDto? Meal
    {
        get => _meal;
        set => _meal = value;
    }

    [MaxLength(250)]
    public string? LastPreparedAt
    {
        get => _lastPreparedAt;
        set => _lastPreparedAt = value;
    }

    public required bool WasPrepared
    {
        get => _wasPrepared;
        set => _wasPrepared = value;
    }

    public static GetMealDto Create(SpoonacularGetMealDto? meal, string? lastPreparedAt, bool wasPrepared)
    {
        return new GetMealDto()
        {
            Meal = meal,
            LastPreparedAt = lastPreparedAt,
            WasPrepared = wasPrepared
        };
    }
}