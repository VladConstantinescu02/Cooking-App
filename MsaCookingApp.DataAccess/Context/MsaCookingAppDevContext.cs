using Microsoft.EntityFrameworkCore;
using MsaCookingApp.DataAccess.Entities;

namespace MsaCookingApp.DataAccess.Context;

public class MsaCookingAppDevContext : DbContext
{
    public DbSet<Challenge> Challenges { get; set; }
    public DbSet<ChallengeStatus> ChallengeStatuses { get; set; }
    public DbSet<ChallengeSubmission> ChallengeSubmissions { get; set; }
    public DbSet<DietaryOption> DietaryOptions { get; set; }
    public DbSet<Fridge> Fridges { get; set; }
    public DbSet<FridgeIngredient> FridgeIngredients { get; set; }
    public DbSet<Ingredient> Ingredients { get; set; }
    public DbSet<Meal> Meals { get; set; }
    public DbSet<MealCuisine> MealCuisines { get; set; }
    public DbSet<MealType> MealTypes { get; set; }
    public DbSet<Profile> Profiles { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<WeeklyRanking> WeeklyRankings { get; set; }
    public DbSet<WeeklyRankingProfileRank> WeeklyRankingProfileRanks { get; set; }

    public MsaCookingAppDevContext(DbContextOptions<MsaCookingAppDevContext> options)
    : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ChallengeSubmission>()
            .HasMany<Profile>((cs) => cs.ProfilesThatVoted)
            .WithMany((p) => p.ChallengeSubmissionsVoted);

        modelBuilder.Entity<ChallengeSubmission>()
            .HasOne<Profile>((cs) => cs.Profile);
        
        modelBuilder.Entity<FridgeIngredient>()
            .HasKey(fi => new { fi.FridgeId, fi.IngredientId });
        
        modelBuilder.Entity<WeeklyRankingProfileRank>()
            .HasKey(wrpr => new { wrpr.WeeklyRankingId, wrpr.ProfileId });
        
        base.OnModelCreating(modelBuilder);
    }
}