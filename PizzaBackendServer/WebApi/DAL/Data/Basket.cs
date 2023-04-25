using Microsoft.Identity.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data
{
    public partial class Basket
    {
        public int Id { get; set; }
        public int Amount { get; set; }
        public decimal Price { get; set; }
        public int UserId { get; set; }
        public int PizzaId { get; set; }
        public virtual Pizza Pizza { get; set; }
        public virtual User User { get; set; }

    }
}
