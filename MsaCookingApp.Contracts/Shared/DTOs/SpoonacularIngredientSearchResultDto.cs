using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Shared.DTOs;

public class SpoonacularIngredientSearchResultDto
{
    private string _id = "";
    private string _name;
    private IEnumerable<SpoonacularIngredientSearchResultChildDto> _children = new List<SpoonacularIngredientSearchResultChildDto>();

    public string Id
    {
        get => _id;
        set => _id = value;
    }

    public required string Name
    {
        get => _name;
        [MemberNotNull(nameof(_name))] set => _name = value;
    }

    public IEnumerable<SpoonacularIngredientSearchResultChildDto> Children
    {
        get => _children;
        set => _children = value;
    }

    public static SpoonacularIngredientSearchResultDto Create(string id, string name)
    {
        return new SpoonacularIngredientSearchResultDto()
        {
            Id = id,
            Name = name
        };
    }
}