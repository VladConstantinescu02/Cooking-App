using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class GetIngredientMeasuringUnitsResultDto
{
    private string _message;
    private IEnumerable<GetIngredientMeasuringUnitDto> _ingredientMeasuringUnits = new List<GetIngredientMeasuringUnitDto>();

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public required IEnumerable<GetIngredientMeasuringUnitDto> IngredientMeasuringUnits
    {
        get => _ingredientMeasuringUnits;
        [MemberNotNull(nameof(_ingredientMeasuringUnits))]
        set => _ingredientMeasuringUnits = value;
    }

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