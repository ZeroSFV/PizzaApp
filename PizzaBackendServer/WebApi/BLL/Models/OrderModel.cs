using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class OrderModel
    {
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
        public OrderModel() { }

        public OrderModel(Order o)
        {
            Id = o.Id;
            CreationTime = o.CreationTime;
            FinishedTime = o.FinishedTime;
            Price = o.Price;
            Address = o.Address;
            PhoneNumber = o.PhoneNumber;
            ClientId = o.ClientId;
            WorkerId = o.WorkerId;
            CourierId = o.CourierId;
            StatusId = o.StatusId;
        }
    }
}
