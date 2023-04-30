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
using Org.BouncyCastle.Tls.Crypto.Impl.BC;

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
            return dataBase.OrderRepository.GetAll()
                                           .Select(i => new OrderModel(i, dataBase))
                                           .ToList();
        }

        public List<OrderModel> GetOrdersOfUser(int userId)
        {
            return dataBase.OrderRepository.GetAll()
                                           .Select(i => new OrderModel(i, dataBase))
                                           .Where(i => i.ClientId == userId)
                                           .ToList();
        }

        public List<OrderModel> GetOrdersOfWorker(int workerId)
        {
            return dataBase.OrderRepository.GetAll()
                                           .Select(i => new OrderModel(i, dataBase))
                                           .Where(i => i.WorkerId == workerId)
                                           .ToList();
        }

        public List<OrderModel> GetOrdersOfCourier(int courierId)
        {
            return dataBase.OrderRepository.GetAll()
                                           .Select(i => new OrderModel(i, dataBase))
                                           .Where(i => i.CourierId == courierId)
                                           .ToList();
        }

        public OrderModel GetActiveOrderByUserId(int userId)
        {
            var orderModel =  dataBase.OrderRepository.GetAll()
                                               .Select(i => new OrderModel(i, dataBase))
                                               .Where(i => i.ClientId == userId)
                                               .Where(i => i.StatusId < 5)
                                               .FirstOrDefault();
            return orderModel;
        }

        public bool CheckIfOrderCanBeCancelled(int orderId)
        {
            var curOrder = dataBase.OrderRepository.Get(orderId);
            if (curOrder != null)
            {
                if (curOrder.StatusId < 3)
                    return true;
                else return false;
            }
            else return false;
        }

        public void CancelThisOrder(int orderId)
        {
            var curOrder = dataBase.OrderRepository.Get(orderId);
            if (curOrder != null)
            {
                curOrder.StatusId = 6;
                Save();
            }
        }

        public void AcceptOrderWorker(int workerId, int orderId)
        {
            var order = dataBase.OrderRepository.Get(orderId);
            var worker = dataBase.UserRepository.Get(workerId);
            if (worker != null && order != null && order.StatusId == 1)
            {
                order.WorkerId = worker.Id;
                order.Worker = worker;
                order.StatusId++;
                Save();
            }
        }

        public void AcceptOrderCourier(int courierId, int orderId)
        {
            var order = dataBase.OrderRepository.Get(orderId);
            var courier = dataBase.UserRepository.Get(courierId);
            if (courier != null && order != null && order.StatusId == 3)
            {
                order.CourierId = courier.Id;
                order.Courier = courier;
                order.StatusId++;
                Save();
            }
        }

        public void ChangeToNextStatus(int orderId)
        {
            var order = dataBase.OrderRepository.Get(orderId);
            if (order != null && order.StatusId < 5)
            {
                order.StatusId++;
                Save();
            }
        }


        public OrderModel GetActiveOrderOfWorker(int workerId)
        {
            var orderModel = dataBase.OrderRepository.GetAll()
                                               .Select(i => new OrderModel(i, dataBase))
                                               .Where(i => i.WorkerId == workerId)
                                               .Where(i => i.StatusId == 2)
                                               .FirstOrDefault();
            return orderModel;
        }

        public List<OrderModel> GetActiveOrdersOfCourier(int courierId)
        {
            var orderModel = dataBase.OrderRepository.GetAll()
                                           .Select(i => new OrderModel(i, dataBase))
                                           .Where(i => i.CourierId == courierId)
                                           .Where(i => i.StatusId == 4)
                                           .ToList();
            return orderModel;
        }

        public List<OrderModel> GetUnacceptedByWorkerOrders()
        {
            var orders = dataBase.OrderRepository.GetAll()
                                                 .Select(i => new OrderModel(i, dataBase))
                                                 .Where(i => i.StatusId == 1)
                                                 .Where(i => i.WorkerId == null)
                                                 .Where(i => i.CourierId == null)
                                                 .ToList();
            return orders;
        }

        public List<OrderModel> GetUnacceptedByCourierOrders()
        {
            var orders = dataBase.OrderRepository.GetAll()
                                                 .Select(i => new OrderModel(i, dataBase))
                                                 .Where(i => i.StatusId == 3)
                                                 .Where(i => i.WorkerId != null)
                                                 .Where(i => i.CourierId == null)
                                                 .ToList();
            return orders;
        }

        public int MakeOrder(MakeOrderModel makeOrderModel)
        {
            var client = dataBase.UserRepository.Get(makeOrderModel.ClientId);
            var baskets = dataBase.BasketRepository.GetAll()
                                                   .Where(i => i.UserId == makeOrderModel.ClientId)
                                                   .ToList();
            var order = new Order();
            if (client != null)
            {
                order.ClientId = makeOrderModel.ClientId;
                order.Client = client;
            }
            order.CreationTime = DateTime.Now;
            order.Address = makeOrderModel.Address;
            order.PhoneNumber = makeOrderModel.PhoneNumber;
            order.ClientName = makeOrderModel.ClientName;
            order.PayingType = makeOrderModel.PayingType;
            if (makeOrderModel.Change != null)
            {
                order.Change = makeOrderModel.Change;
            }
            order.Price = 0;
            if (baskets != null)
            {
                foreach (var b in baskets)
                {
                    order.Price += b.Price;
                }
            }
            order.StatusId = 1;
            order.Status = dataBase.StatusRepository.Get(order.StatusId);
            if (client != null && baskets != null)
            {
                dataBase.OrderRepository.Create(order);

                Save();
            }
            else 
            {
                return 0;
            }
            var orders = dataBase.OrderRepository.GetAll()
                                                 .ToList();
            if (orders.Count > 0)
            {
                int key = orders[orders.Count - 1].Id;
                foreach (var i in baskets)
                {
                    OrderString line = new OrderString();
                    line.Count = i.Amount;
                    line.OrderId = key;
                    line.PizzaId = i.PizzaId;
                    line.Order = dataBase.OrderRepository.Get(key);
                    line.Pizza = i.Pizza;
                    order = dataBase.OrderRepository.Get(key);
                    if (order != null)
                    {
                        order.OrderStrings.Add(line);
                        dataBase.OrderStringRepository.Create(line);
                        dataBase.OrderRepository.Update(order);
                       // dataBase.OrderStringRepository.Create(line);
                        Save();
                    }
                    else
                    {
                        return 0;
                    }
                }
                Save();

                var basketsToDelete = dataBase.BasketRepository.GetAll()
                                                               .Where(i => i.UserId == makeOrderModel.ClientId)
                                                               .ToList();
                foreach (var bTD in basketsToDelete)
                {
                    dataBase.BasketRepository.Delete(bTD.Id);
                    Save();
                }
                Save();
                return 1;
            }
            else return 0;
        }

        public bool Save()
        {
            dataBase.Save();
            return true;
        }
    }
}
