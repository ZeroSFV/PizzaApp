using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Interfaces;
using DAL.Data;
using DAL.Interfaces;
using DAL.Repository;

namespace BLL.Models
{
    public class UnitOfWork : BLL.Interfaces.IUnitOfWork
    {
        private readonly PizzaContext _context;
        private IGenericRepository<Pizza> _pizzaRep;
        private IGenericRepository<Size> _sizeRep;
        private IGenericRepository<Status> _statusRep;
        private IGenericRepository<Order> _orderRep;
        private IGenericRepository<OrderString> _orderStringRep;
        private IGenericRepository<Basket> _basketRep;
        private IGenericRepository<User> _userRep;

        public UnitOfWork()
        {
            _context = new PizzaContext();
        }
        public IGenericRepository<Pizza> PizzaRepository => _pizzaRep ??= new GenericRepository<Pizza>(_context);
        public IGenericRepository<Size> SizeRepository => _sizeRep ??= new GenericRepository<Size>(_context);
        public IGenericRepository<Status> StatusRepository => _statusRep ??= new GenericRepository<Status>(_context);
        public IGenericRepository<Order> OrderRepository => _orderRep ??= new GenericRepository<Order>(_context);
        public IGenericRepository<OrderString> OrderStringRepository => _orderStringRep ??= new GenericRepository<OrderString>(_context);
        public IGenericRepository<Basket> BasketRepository => _basketRep ??= new GenericRepository<Basket>(_context);
        public IGenericRepository<User> UserRepository => _userRep ??= new GenericRepository<User>(_context);

        public async Task Save()
        {
            await _context.SaveChangesAsync();
        }
    }
}
