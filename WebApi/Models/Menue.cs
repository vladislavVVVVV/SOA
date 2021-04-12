using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WebApi.Models {

    public class Menue {

        [Key]
        public int id { get; set; }
        public string name { get; set; }
        public ICollection<Recipe> recipes { get; set; }
    }

}