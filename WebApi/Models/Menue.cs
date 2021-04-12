using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models {

    public class Menue {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int MenueId { get; set; }
        public string Name { get; set; }
        public virtual ICollection<Recipe> Recipes { get; set; }
    }

}