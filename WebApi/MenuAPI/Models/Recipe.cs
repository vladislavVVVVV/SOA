using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models {

    public class Recipe {
        // public Recipe()
        // {
            // Ingredients = new List<Ingredient>();
            //  this.Menues = new HashSet<Menue>();
        // }
    
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int RecipeId { get; set; }
        public string Name { get; set; }
        // public List<IngredientRecipe> IngredientRecipes { get; set; }
        public List<int> IngredientIds { get; set; } = new List<int>();
    }

}