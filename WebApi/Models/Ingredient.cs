using System.ComponentModel.DataAnnotations;

namespace WebApi.Models {

    public class Ingredient {

        [Key]
        public int id { get; set; }
        public string name { get; set; }
        public int proteins { get; set; }
        public int carbohydrates { get; set; }
        public int fats { get; set; }
    }

}