using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebApi.Models {

    public class Ingredient {
        [Key]
        public int IngredientId { get; set; }
        public string Name { get; set; }
        public int Proteins { get; set; }
        public int Carbohydrates { get; set; }
        public int Fats { get; set; }
        } 

}