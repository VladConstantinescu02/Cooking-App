﻿using System.ComponentModel.DataAnnotations;

namespace MsaCookingApp.DataAccess.Entities;

public class Ingredient
{
    [Key] [MaxLength(250)] public string Id { get; set; } = "";
    [Required]
    [MaxLength(250)]
    public required string Name { get; set; }
    [Required]
    public required double CaloriesPer100Grams { get; set; }

    public virtual ICollection<Meal> Meals { get; set; } = new List<Meal>();
    public virtual ICollection<Profile> AllergicProfiles { get; set; } = new List<Profile>();

    public static Ingredient Create(string id, string name, double caloriesPer100Grams)
    {
        return new Ingredient()
        {
            Id = id,
            Name = name,
            CaloriesPer100Grams = caloriesPer100Grams
        };
    }
}