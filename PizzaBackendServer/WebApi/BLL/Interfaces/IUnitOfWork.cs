using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;
using DAL.Interfaces;

namespace BLL.Interfaces
{
    public interface IUnitOfWork
    {
        IGenericRepository<Pizza> PizzaRepository { get; }
        IGenericRepository<Size> SizeRepository { get; }
        IGenericRepository<Status> StatusRepository { get; }
        IGenericRepository<Order> OrderRepository { get; }
        IGenericRepository<OrderString> OrderStringRepository { get; }
        IGenericRepository<Basket> BasketRepository { get; }
        IGenericRepository<User> UserRepository { get; }
        Task Save();
    }
}
