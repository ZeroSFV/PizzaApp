using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using BLL.Models;
using BLL.Interfaces;
using BLL;
using Microsoft.AspNetCore.Authorization;
using System.Net.Http.Headers;

namespace WebApi.Controllers
{
    [ApiController]
    [Route("api/pizza")]
    public class PizzaController : ControllerBase
    {
        private readonly IPizzaService _iPizzaService;
        public PizzaController(IPizzaService iPizzaService)
        {
            _iPizzaService = iPizzaService;
        }

        [HttpGet]
        public IActionResult GetAllPizzas()
        {
            try
            {
                List<PizzaModel> allPizzas = _iPizzaService.GetAllPizzas();
                if (allPizzas.Count != 0)
                    return new ObjectResult(allPizzas);
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "Список пицц получить не удалось!" });
            }
            catch (Exception e) 
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("bydescription/{description}")]
        public IActionResult GetPizzasWithDescription(string description)
        {
            try
            {
                List<PizzaModel> allPizzas = _iPizzaService.GetPizzasWithDescription(description);
                if (allPizzas.Count != 0)
                    return new ObjectResult(allPizzas);
                else return BadRequest(new ErrorResponseModel { Status = 500, Description="Пицц с данным описанием не существует!" });
            }
            catch (Exception e) 
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("byname/{name}")]
        public IActionResult GetPizzasWithName(string name)
        {
            try
            {
                List<PizzaModel> Pizza = _iPizzaService.GetPizzasByName(name);
                if (Pizza.Count != 0)
                    return new ObjectResult(Pizza);
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "При получении пицц с таким именем произошла ошибка" });
            }
            catch (Exception e)
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description=e.Message });
            }
        }

        [HttpPut("changePizza")]
        public IActionResult UpdatePizza([FromBody] PizzaChangeModel pizzaChangeModel)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    _iPizzaService.UpdatePizza(pizzaChangeModel);

                    var msg = new
                    {
                        message = "Изменения пиццы внесены"
                    };
                    return Ok(msg);
                }
                catch 
                {
                    return BadRequest(new ErrorResponseModel { Status = 500, Description = "Изменить пиццу не получилось!" });
                }
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные"});
            }
        }
    }
}
