using WebApi.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;

namespace WebApi.Data {
    public class RecipesContext : IdentityDbContext {
    public RecipesContext(DbContextOptions options) : base(options) { }

    protected override void OnModelCreating(ModelBuilder builder) {
        base.OnModelCreating(builder);
        builder.Entity<Ingredient>().Property(p => p.Name).HasMaxLength(40);
        builder.Entity<Recipe>().Property(p => p.Name).HasMaxLength(40);
        builder.Entity<Menue>().Property(p => p.Name).HasMaxLength(40);

        builder.Entity<Ingredient>().ToTable("Ingredients");
        builder.Entity<Recipe>().ToTable("Recipes");
        builder.Entity<Menue>().ToTable("Menues");
    }

    public DbSet<Ingredient> Ingredients { get; set; }
    public DbSet<Recipe> Recipes { get; set; }
    public DbSet<Menue> Menues { get; set; }

    }

}