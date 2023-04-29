
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data
{
    public partial class Basket
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int Amount { get; set; }
        public decimal Price { get; set; }
        public int UserId { get; set; }
        public int PizzaId { get; set; }
        public virtual Pizza Pizza { get; set; } = null!;
        public virtual User User { get; set; } = null!;

    }
}
