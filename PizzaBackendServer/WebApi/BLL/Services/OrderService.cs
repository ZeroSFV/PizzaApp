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
    public class OrderService : IOrderService
    {
        IUnitOfWork dataBase;

        public OrderService(IUnitOfWork repos)
        {
            dataBase = repos;
        }

        public List<OrderModel> GetAllOrders()
        {
            return dataBase.OrderRepository.GetAll().Select(i => new OrderModel(i)).ToList();
        }
    }
}
