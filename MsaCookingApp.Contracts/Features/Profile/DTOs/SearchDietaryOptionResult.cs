using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class SearchDietaryOptionResult
{
    private int _id;
    private string _name;

    public int Id
    {
        get => _id;
        set => _id = value;
    }

    public required string Name
    {
        get => _name;
        [MemberNotNull(nameof(_name))] set => _name = value;
    }

    public static SearchDietaryOptionResult Create(int id, string name)
    {
        return new SearchDietaryOptionResult()
        {
            Id = id,
            Name = name
        };
    }   
}