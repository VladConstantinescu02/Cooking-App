namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class GetIngredientMeasuringUnitDto
{
    public int Id { get; set; }
    public required string UnitName { get; set; }
    public required string UnitSuffix { get; set; }

    public static GetIngredientMeasuringUnitDto Create(int id, string unitName, string unitSuffix)
    {
        return new GetIngredientMeasuringUnitDto()
        {
            Id = id,
            UnitName = unitName,
            UnitSuffix = unitSuffix
        };
    }
}