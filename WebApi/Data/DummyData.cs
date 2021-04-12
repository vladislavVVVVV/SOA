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
            new Ingredient {name = "TestName 1", proteins = 100, carbohydrates = 1, fats = 120},
            new Ingredient {name = "TestName 2", proteins = 10, carbohydrates = 10, fats = 130},
            new Ingredient {name = "TestName 3", proteins = 10, carbohydrates = 100, fats = 130},
            };
            return ingredients;
        }

        public static List<Recipe> GetRecipes(RecipesContext db)
        {
            List<Recipe> recipes = new List<Recipe>() {
            new Recipe {
                name = "TestName 1",
                ingredients = new List<Ingredient>(db.Ingredients.Take(2))
            },
            new Recipe {
                name = "TestName 2",
                ingredients = new List<Ingredient>(db.Ingredients.OrderBy(m => m.name).Skip(1).Take(2))
            },
            new Recipe {
                name = "TestName 3",
                ingredients = new List<Ingredient>(db.Ingredients.OrderBy(m => m.fats).Take(2))
            },
            };
            return recipes;
        }
    
    public static List<Menue> GetMenues(RecipesContext db)
        {
            List<Menue> menues = new List<Menue>() {
            new Menue {
                name = "TestName 1",
                recipes = new List<Recipe>(db.Recipes.Take(2))
            },
            new Menue {
                name = "TestName 2",
                recipes = new List<Recipe>(db.Recipes.OrderBy(m => m.name).Skip(1).Take(2))
            },
            new Menue {
                name = "TestName 3",
                recipes = new List<Recipe>(db.Recipes.OrderBy(m => m.name).Take(2))
            },
            };
            return menues;
        }
    }

}