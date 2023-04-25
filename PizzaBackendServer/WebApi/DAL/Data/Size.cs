using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data
{
    public partial class Size
    {
        public Size()
        {
            Pizzas = new HashSet<Pizza>();
        }
        
        public int Id { get; set; }
        public string Name { get; set; }
        public virtual ICollection<Pizza>? Pizzas { get; set; }

    }
}
