namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class SearchDietaryOptionResult
{
    public int Id { get; set; }
    public required string Name { get; set; }

    public static SearchDietaryOptionResult Create(int id, string name)
    {
        return new SearchDietaryOptionResult()
        {
            Id = id,
            Name = name
        };
    }   
}