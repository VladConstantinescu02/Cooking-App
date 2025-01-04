namespace MsaCookingApp.Contracts.Shared.DTOs;

public class ProfileDietRestricionDto
{
    public int Id { get; set; }
    public required string Name { get; set; }

    public static ProfileDietRestricionDto Create(int id, string name)
    {
        return new ProfileDietRestricionDto()
        {
            Id = id,
            Name = name
        };
    }
}