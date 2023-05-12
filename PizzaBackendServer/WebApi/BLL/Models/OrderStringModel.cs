using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Interfaces;
using DAL.Data;
using Microsoft.EntityFrameworkCore.Storage;
using MimeKit.Cryptography;

namespace BLL.Models
{
    public class OrderStringModel
    {
        public int Id { get; set; }
        public int Count { get; set; }
        public int PizzaId { get; set; }
        public int OrderId { get; set; }
        public string? PizzaName { get; set; }
        public string? SizeName { get; set; }
        public decimal? PizzaPrice { get; set; }


      //  public PizzaModel Pizza { get; set; }
        public OrderStringModel() { }

        public OrderStringModel(OrderString os, IUnitOfWork dataBase)
        {
            Id = os.Id;
            Count = os.Count;
            PizzaId = os.PizzaId;
            OrderId = os.OrderId;
            var pizza = dataBase.PizzaRepository.Get(PizzaId);
            //Pizza = new PizzaModel(dataBase.PizzaRepository.Get(os.PizzaId), dataBase);
            if (pizza != null)
            {
                PizzaName = pizza.Name;
                PizzaPrice = pizza.Price;
                var size = dataBase.SizeRepository.Get(pizza.SizeId);
                if (size != null)
                {
                    SizeName = size.Name;
                }
            }
        }
    }
}
