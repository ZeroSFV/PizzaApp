using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data
{
    public partial class Status
    {
        public Status() 
        {
            Orders = new HashSet<Order>();
        } 
        public int Id { get; set; }
        public string Name { get; set; }
        public virtual ICollection<Order>? Orders { get; set; }

    }
}
