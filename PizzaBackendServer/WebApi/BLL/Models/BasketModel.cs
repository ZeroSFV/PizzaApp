using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Interfaces;
using DAL.Data;

namespace BLL.Models
{
    public class BasketModel
    {
        public int Id { get; set; }
        public int Amount { get; set; }
        public decimal Price { get; set; }
        public int UserId { get; set; }
        public int PizzaId { get; set; }
        public string PizzaName { get; set; }
        public string SizeName { get; set; }
        public BasketModel() { }

        public BasketModel(Basket b, IUnitOfWork dataBase)
        {
            Id = b.Id;
            Amount = b.Amount;
            Price = b.Price;
            UserId = b.UserId;
            PizzaId = b.PizzaId;
            var pizza = dataBase.PizzaRepository.Get(b.PizzaId);
            if (pizza != null)
            {
                PizzaName = pizza.Name;
                var size = dataBase.SizeRepository.Get(pizza.SizeId);
                if (size != null)
                {
                    SizeName = size.Name;
                }
            }

        }
    }
}
