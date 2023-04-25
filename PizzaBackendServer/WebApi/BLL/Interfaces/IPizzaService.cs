using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Models;

namespace BLL.Interfaces
{
    public interface IPizzaService
    {
        List<PizzaModel> GetAllPizzas();
        List<PizzaModel> GetPizzasWithDescription(string description);
        List<PizzaModel> GetPizzasByName(string name);
        void UpdatePizza(PizzaChangeModel pm);

    }
}
