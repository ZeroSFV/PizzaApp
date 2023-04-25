using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class PizzaModel
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public decimal Price { get; set; }
        public string Description { get; set; } = null!;
        public bool Prescence { get; set; }
        public string Consistance { get; set; } = null!;
        public int SizeId { get; set; }
        public string? Photo { get; set; }
        public PizzaModel() { } 

        public PizzaModel(Pizza p)
        {
            Id = p.Id;
            Name = p.Name;
            Price = p.Price;
            Description = p.Description;
            Prescence = !(p.Prescence==0);
            Consistance = p.Consistance;
            SizeId = p.SizeId;
            Photo = p.Photo;
        }
    }
}
