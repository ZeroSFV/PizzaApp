using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Models
{
    public class CreateBasketModel
    {
        public int UserId { get; set; }
        public int PizzaId { get; set; }
        public CreateBasketModel() { }

        public CreateBasketModel(int userId, int pizzaId)
        {
            UserId = userId;
            PizzaId = pizzaId;
        }
    }
}
