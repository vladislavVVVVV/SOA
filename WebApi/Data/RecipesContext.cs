using WebApi.Models;
using Microsoft.EntityFrameworkCore;

namespace WebApi.Data
{public class RecipesContext : DbContext {
    public RecipesContext(DbContextOptions options) : base(options) { }

    protected override void OnModelCreating(ModelBuilder builder) {
        builder.Entity<Ingredient>().Property(p => p.name).HasMaxLength(40);
        builder.Entity<Recipe>().Property(p => p.name).HasMaxLength(40);
        builder.Entity<Menue>().Property(p => p.name).HasMaxLength(40);

        builder.Entity<Ingredient>().ToTable("Ingredients");
        builder.Entity<Recipe>().ToTable("Recipes");
        builder.Entity<Menue>().ToTable("Menues");
    }

    public DbSet<Ingredient> Ingredients { get; set; }
    public DbSet<Recipe> Recipes { get; set; }
    public DbSet<Menue> Menues { get; set; }

}

}