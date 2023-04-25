using Microsoft.Identity.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data
{
    public partial class Order
    {
        public Order()
        {
            OrderStrings = new HashSet<OrderString>();
        }
        public int Id { get; set; }
        public DateTime CreationTime { get; set; }
        public DateTime? FinishedTime { get; set; }
        public decimal Price { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
        public int ClientId { get; set; }
        public int? WorkerId { get; set; }
        public int? CourierId { get; set; }
        public int StatusId { get; set; }
        public virtual User Client { get; set; }
        public virtual User? Worker { get; set; }
        public virtual User? Courier { get; set; }
        public virtual Status Status { get; set; }
        public virtual ICollection<OrderString> OrderStrings { get; set; }
    }
}
