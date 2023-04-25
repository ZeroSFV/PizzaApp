using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class OrderStringModel
    {
        public int Id { get; set; }
        public int Count { get; set; }
        public int PizzaId { get; set; }
        public int OrderId { get; set; }
        public OrderStringModel() { }

        public OrderStringModel(OrderString os)
        {
            Id = os.Id;
            Count = os.Count;
            PizzaId = os.PizzaId;
            OrderId = os.OrderId;
        }
    }
}
