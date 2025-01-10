namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SpoonacularGetMealInstructionStepDto
{
    public required int Number { get; set; }
    public required string Step { get; set; }

    public IEnumerable<SpoonacularGetMealInstructionStepIngredientDto> Ingredients { get; set; } =
        new List<SpoonacularGetMealInstructionStepIngredientDto>();
    
    public IEnumerable<SpoonacularGetMealInstructionStepEquipmentDto> Equipment { get; set; } =
        new List<SpoonacularGetMealInstructionStepEquipmentDto>();
}