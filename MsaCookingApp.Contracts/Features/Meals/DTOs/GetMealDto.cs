using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetMealDto
{
    public SpoonacularGetMealDto? Meal { get; set; }
    [MaxLength(250)]
    public string? LastPreparedAt { get; set; }
    public required bool WasPrepared { get; set; } = false;

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