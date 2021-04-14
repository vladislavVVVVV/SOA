using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using WebApi.Models;

namespace WebApi.Models {

    public class IngredientRecipe {
        public int  IngredientRecipeId { get; set; }
        public int IngredientId { get; set; }
        public virtual Ingredient Ingredient { get; set; }
 
        public int RecipeId { get; set; }
        public virtual Recipe Recipe { get; set; }
     
    }

}