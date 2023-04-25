using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data
{
    public partial class Pizza
    {
        public Pizza()
        {
            Baskets = new HashSet<Basket>();
            OrderStrings = new HashSet<OrderString>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public decimal Price { get; set; }
        public string Description { get; set; } = null!;
        public sbyte Prescence { get; set; }
        public string Consistance { get; set; } = null!;
        public int SizeId { get; set; } 
        public string? Photo { get; set; }

       
        public virtual Size Size { get; set; }
        public virtual ICollection<Basket>? Baskets { get; set; }
        public virtual ICollection<OrderString>? OrderStrings { get; set; }


    }
}
