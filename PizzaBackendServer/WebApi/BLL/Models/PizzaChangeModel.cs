using DAL.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Models
{
    public class PizzaChangeModel
    {
        public string Name { get; set; } = null!;
        public decimal PriceForBig { get; set; }
        public decimal PriceForMedium { get; set; }
        public string Description { get; set; } = null!;
        public bool Prescence { get; set; }
        public string Consistance { get; set; } = null!;
        public PizzaChangeModel() { }

        public PizzaChangeModel(string name, decimal priceForBig, decimal priceForMedium, string description, bool prescence, string consistance)
        {
            Name = name;
            PriceForBig = priceForBig;
            PriceForMedium = priceForMedium;
            Description = description;
            Prescence = prescence;
            Consistance = consistance;
        }
    }
}
