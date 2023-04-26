using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Interfaces;
using DAL.Data;
using BLL.Models;
using System.Collections.ObjectModel;
using System.IdentityModel.Tokens.Jwt;
using MimeKit;
using MailKit.Net.Smtp;
using Newtonsoft.Json;

namespace BLL.Services
{
    public class PizzaService : IPizzaService
    {
        IUnitOfWork dataBase;

        public PizzaService(IUnitOfWork repos)
        {
            dataBase = repos;
        }

        public List<PizzaModel> GetAllPizzas()
        {
            return dataBase.PizzaRepository.GetAll()
                                           .Select(i => new PizzaModel(i))
                                           .Where(i => i.SizeId == 2)
                                           .Where(i => i.Prescence == true)
                                           .ToList();
        }

        public List<PizzaModel> GetPizzasWithDescription(string description)
        {
            return dataBase.PizzaRepository.GetAll()
                                           .Select(i => new PizzaModel(i))
                                           .Where(i => i.Description.Contains(description) == true)
                                           .Where(i => i.SizeId == 2).Where(i => i.Prescence == true)
                                           .ToList();
        }

        public List<PizzaModel> GetPizzasByName(string name)
        {
            return dataBase.PizzaRepository.GetAll()
                                           .Select(i => new PizzaModel(i))
                                           .Where(i => i.Name == name)
                                           .ToList();
        }

        public void UpdatePizza(PizzaChangeModel pm)
        {
            var pizza = dataBase.PizzaRepository.GetAll()
                                                .Where(i => i.Name == pm.Name)
                                                .ToList();
            if (pizza.Count > 0)
            {
                foreach(var p in pizza)
                {
                    p.Description = pm.Description;
                    p.Consistance = pm.Consistance;
                    if (pm.Prescence == true)
                    {
                        p.Prescence = 1;
                    }
                    else
                    {
                        p.Prescence = 0;
                    }
                    if (p.SizeId == 1)
                        p.Price = pm.PriceForBig;
                    if (p.SizeId == 2)
                        p.Price = pm.PriceForMedium;
                    dataBase.PizzaRepository.Update(p);
                    Save();
                }
            }
        }

        public bool Save()
        {
            dataBase.Save();
            return true;
        }
    }
}
