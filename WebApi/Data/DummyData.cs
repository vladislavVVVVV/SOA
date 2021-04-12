using System.Collections.Generic;
using System.Linq;
using WebApi.Models;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;

namespace WebApi.Data
{
    public class DummyData
    {
        public static void Initialize(IApplicationBuilder app)
        {
            using (var serviceScope = app.ApplicationServices.GetService<IServiceScopeFactory>().CreateScope())
            {
                var context = serviceScope.ServiceProvider.GetService<RecipesContext>();
                context.Database.EnsureCreated();

                if (context.Ingredients != null && context.Ingredients.Any())
                    return;   // DB has already been seeded

                var ingredients = DummyData.GetIngredients().ToArray();
                context.Ingredients.AddRange(ingredients);
                // context.SaveChanges();

                var recipes = DummyData.GetRecipes(context).ToArray();
                context.Recipes.AddRange(recipes);
                // context.SaveChanges();

                var menues = DummyData.GetMenues(context).ToArray();
                context.Menues.AddRange(menues);
                context.SaveChanges();
            }
        }

        public static List<Ingredient> GetIngredients()
        {
            List<Ingredient> ingredients = new List<Ingredient>() {
            new Ingredient {Name = "TestName 1", Proteins = 100, Carbohydrates = 1, Fats = 120},
            new Ingredient {Name = "TestName 2", Proteins = 10, Carbohydrates = 10, Fats = 130},
            new Ingredient {Name = "TestName 3", Proteins = 10, Carbohydrates = 100, Fats = 130},
            };
            return ingredients;
        }

        public static List<Recipe> GetRecipes(RecipesContext db)
        {
            List<Recipe> recipes = new List<Recipe>() {
            new Recipe {
                Name = "TestName 1",
                Ingredients = new List<Ingredient>(db.Ingredients.Take(2))
            },
            new Recipe {
                Name = "TestName 2",
                Ingredients = new List<Ingredient>(db.Ingredients.OrderBy(m => m.Name).Skip(1).Take(2))
            },
            new Recipe {
                Name = "TestName 3",
                Ingredients = new List<Ingredient>(db.Ingredients.OrderBy(m => m.Fats).Take(2))
            },
            };
            return recipes;
        }
    
    public static List<Menue> GetMenues(RecipesContext db)
        {
            List<Menue> menues = new List<Menue>() {
            new Menue {
                Name = "TestName 1",
                Recipes = new List<Recipe>(db.Recipes.Take(2))
            },
            new Menue {
                Name = "TestName 2",
                Recipes = new List<Recipe>(db.Recipes.OrderBy(m => m.Name).Skip(1).Take(2))
            },
            new Menue {
                Name = "TestName 3",
                Recipes = new List<Recipe>(db.Recipes.OrderBy(m => m.Name).Take(2))
            },
            };
            return menues;
        }
    }

}