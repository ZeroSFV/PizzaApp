using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data
{
    public partial class OrderString
    {
       public int Id { get; set; }
       public int Count { get; set; }
       public int PizzaId { get; set; }
       public int OrderId { get; set; }
        public virtual Order Order { get; set; } = null!;
       public virtual Pizza Pizza { get; set; } = null!;
        
    }
}
