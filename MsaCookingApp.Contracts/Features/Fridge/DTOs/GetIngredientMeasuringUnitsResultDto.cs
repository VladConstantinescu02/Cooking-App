namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class GetIngredientMeasuringUnitsResultDto
{
    public required string Message { get; set; }

    public required IEnumerable<GetIngredientMeasuringUnitDto> IngredientMeasuringUnits { get; set; } =
        new List<GetIngredientMeasuringUnitDto>();

    public static GetIngredientMeasuringUnitsResultDto Create(string message,
        IEnumerable<GetIngredientMeasuringUnitDto> ingredientMeasuringUnits)
    {
        return new GetIngredientMeasuringUnitsResultDto()
        {
            Message = message,
            IngredientMeasuringUnits = ingredientMeasuringUnits
        };
    }
}