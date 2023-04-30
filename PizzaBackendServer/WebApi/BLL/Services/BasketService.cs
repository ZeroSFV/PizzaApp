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
using Microsoft.Extensions.Logging;

namespace BLL.Services
{
    public class BasketService : IBasketService
    {
        IUnitOfWork dataBase;

        public BasketService(IUnitOfWork repos)
        {
            dataBase = repos;
        }

        public List<BasketModel> GetAllBasketsByUserId(int userId)
        {
            return dataBase.BasketRepository.GetAll()
                                            .Select(i => new BasketModel(i))
                                            .Where(i => i.UserId == userId)
                                            .ToList();
        }

        public void DeleteBasket(int basketId)
        {
            var basket = dataBase.BasketRepository.Get(basketId);
            if (basket != null)
            {
                dataBase.BasketRepository.Delete(basket.Id);
                Save();
            }
        }

        public void UpdateBasket(BasketModel basket)
        {
            var basketToChange = dataBase.BasketRepository.Get(basket.Id);
            var pizza = dataBase.PizzaRepository.Get(basket.PizzaId);
            if (pizza != null && basketToChange != null)
            {
                basketToChange.Amount = basket.Amount;
                basketToChange.Price = pizza.Price * basket.Amount;
                //basket.ViewPrice = $"{basket.Basket_Price:0.#} руб.";
                dataBase.BasketRepository.Update(basketToChange);
                Save();
            }
        }

        public void CreateBasket(CreateBasketModel createBasketModel)
        {
            var user = dataBase.UserRepository.Get(createBasketModel.UserId);
            var pizza = dataBase.PizzaRepository.Get(createBasketModel.PizzaId);
            var basket = dataBase.BasketRepository.GetAll().Where(i => i.UserId == createBasketModel.UserId).Where(i => i.PizzaId == createBasketModel.PizzaId).FirstOrDefault();
            if (user != null && pizza != null)
            {
                if (basket != null)
                {
                    basket.Amount++;
                    basket.Price += pizza.Price;
                    dataBase.BasketRepository.Update(basket);
                }
                else { dataBase.BasketRepository.Create(new Basket { Amount = 1, Price = pizza.Price, PizzaId = pizza.Id, UserId = user.Id, Pizza = pizza, User = user}); }
                Save();
            }
        }

        public bool Save()
        {
            dataBase.Save();
            return true;
        }
    }
}
