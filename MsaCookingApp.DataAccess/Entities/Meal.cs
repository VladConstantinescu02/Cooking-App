using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class Meal
{
    [Key]
    public required Guid Id { get; set; }
    [Required]
    [MaxLength(10)]
    public required string SpoonacularId { get; set; }
    [Required]
    [MaxLength(250)]
    public required string Name { get; set; }
    [Required]
    [MaxLength(250)]
    public required string Summary { get; set; }
    [Required]
    public required double ReadyInMinutes { get; set; }
    [MaxLength(250)]
    public string? Image { get; set; }
    [MaxLength(250)]
    public string? LastPreparedAt { get; set; }
    public required bool WasPrepared { get; set; }
    [Required]
    public required Guid ProfileId { get; set; }
    
    [MaxLength(250)]
    public string? IngredientsJson { get; set; }

    public virtual Profile Profile { get; set; } = null!;
    public virtual ICollection<Ingredient> Ingredients { get; set; } = new List<Ingredient>();
    
    public static Meal Create(
        string id,
        string name,
        string summary,
        double readyInMinutes,
        bool wasPrepared,
        Guid profileId,
        string? image = null,
        string? lastPreparedAt = null,
        string? ingredientsJson = null)
    {
        return new Meal
        {
            Id = Guid.NewGuid(),
            SpoonacularId = id,
            Name = name,
            Summary = summary,
            ReadyInMinutes = readyInMinutes,
            WasPrepared = wasPrepared,
            ProfileId = profileId,
            Image = image,
            LastPreparedAt = lastPreparedAt,
            IngredientsJson = ingredientsJson
        };
    }
}