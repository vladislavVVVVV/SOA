using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WebApi.Models {

    public class Recipe {
        [Key]
        public int id { get; set; }
        public string name { get; set; }
        public IEnumerable<Ingredient> ingredients { get; set; }
    }

}