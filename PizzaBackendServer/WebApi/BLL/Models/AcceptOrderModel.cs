using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class AcceptOrderModel
    {
        public int OrderId { get; set; }
        public int WorkerId { get; set; }
        public int CourierId { get; set; }
        public AcceptOrderModel() { }

        public AcceptOrderModel(int orderId, int workerId, int courierId)
        {
            OrderId = orderId;
            WorkerId = workerId;
            CourierId = courierId;
        }
    }
}
