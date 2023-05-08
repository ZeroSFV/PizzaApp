
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
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
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public DateTime CreationTime { get; set; }
        public DateTime? PredictedTime { get; set; }
        public DateTime? FinishedTime { get; set; }
        public decimal Price { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
        public string ClientName { get; set; }
        public string PayingType { get; set; }
        public decimal? Change { get; set; }
        public int ClientId { get; set; }
        public int? WorkerId { get; set; }
        public int? CourierId { get; set; }
        public int StatusId { get; set; }
        public virtual User Client { get; set; } = null!;
        public virtual User? Worker { get; set; }
        public virtual User? Courier { get; set; }
        public virtual Status Status { get; set; } = null!;
        public virtual ICollection<OrderString> OrderStrings { get; set; }
    }
}
