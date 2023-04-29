using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Interfaces;
using DAL.Data;
using Microsoft.EntityFrameworkCore.Storage;

namespace BLL.Models
{
    public class OrderStringModel
    {
        public int Id { get; set; }
        public int Count { get; set; }
        public int PizzaId { get; set; }
        public int OrderId { get; set; }
        public PizzaModel Pizza { get; set; }
        public OrderStringModel() { }

        public OrderStringModel(OrderString os, IUnitOfWork dataBase)
        {
            Id = os.Id;
            Count = os.Count;
            PizzaId = os.PizzaId;
            OrderId = os.OrderId;
            Pizza = new PizzaModel(dataBase.PizzaRepository.Get(os.PizzaId), dataBase);
        }
    }
}
