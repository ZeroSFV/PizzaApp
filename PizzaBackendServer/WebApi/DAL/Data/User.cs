using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data
{
    public partial class User
    {
        public User() 
        {
            Baskets = new HashSet<Basket>();
            OrdersClient = new HashSet<Order>();
            OrdersWorker = new HashSet<Order>();
            OrdersCourier = new HashSet<Order>();
        }

        public int Id { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }
        public string Phone { get; set; }
        public string? Passport { get; set; }
        public int? Bonuses { get; set; }
        public string Role { get; set; }
        public sbyte IsApproved { get; set; }
        public string? RefreshToken { get; set; }
        public string ApprovalCode { get; set; }
        public virtual ICollection<Basket>? Baskets { get; set; }
        public virtual ICollection<Order>? OrdersClient { get; set; }
        public virtual ICollection<Order>? OrdersWorker { get; set; }
        public virtual ICollection<Order>? OrdersCourier { get; set; }
    }
}
