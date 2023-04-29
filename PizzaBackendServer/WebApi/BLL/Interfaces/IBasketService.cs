using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Models;

namespace BLL.Interfaces
{
    public interface IBasketService
    {
        List<BasketModel> GetAllBasketsByUserId(int userId);
        void DeleteBasket(int basketId);
        void UpdateBasket(BasketModel basket);
        void CreateBasket(CreateBasketModel createBasketModel);
    }
}
