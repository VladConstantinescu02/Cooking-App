namespace MsaCookingApp.Contracts.Shared.DTOs;

public class SpoonacularIngredientSearchResultDto
{
    public string Id { get; set; } = "";
    public required string Name { get; set; }

    public IEnumerable<SpoonacularIngredientSearchResultChildDto> Children { get; set; } =
        new List<SpoonacularIngredientSearchResultChildDto>();

    public static SpoonacularIngredientSearchResultDto Create(string id, string name)
    {
        return new SpoonacularIngredientSearchResultDto()
        {
            Id = id,
            Name = name
        };
    }
}