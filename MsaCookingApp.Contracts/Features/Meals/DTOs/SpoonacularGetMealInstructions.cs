namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class SpoonacularGetMealInstructions
{
    public IEnumerable<SpoonacularGetMealInstructionStepDto> Steps { get; set; } =
        new List<SpoonacularGetMealInstructionStepDto>();
}