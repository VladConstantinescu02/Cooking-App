namespace MsaCookingApp.Contracts.Shared.DTOs;

public class ProfileAlergenDto
{
    public string Id { get; set; }
    public required string Name { get; set; }

    public static ProfileAlergenDto Create(string id, string name)
    {
        return new ProfileAlergenDto()
        {
            Id = id,
            Name = name
        };
    }
}