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
        public async Task<IActionResult> GetAllPizzas()
        {
            if (ModelState.IsValid)
            {
                List<PizzaModel> allPizzas = _iPizzaService.GetAllPizzas();
                return new ObjectResult(allPizzas);   
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения пицц произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpGet("bydescription/{description}")]
        public async Task<IActionResult> GetPizzasWithDescription(string description)
        {
            if (ModelState.IsValid)
            {
                List<PizzaModel> allPizzas = _iPizzaService.GetPizzasWithDescription(description);
                return new ObjectResult(allPizzas);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения пицц произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpGet("byname/{name}")]
        public async Task<IActionResult> GetPizzasWithName(string name)
        {
            if (ModelState.IsValid)
            {
                List<PizzaModel> Pizza = _iPizzaService.GetPizzasByName(name);
                return new ObjectResult(Pizza);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения пицц произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpPut("changePizza")]
        public async Task<IActionResult> UpdatePizza([FromBody] PizzaChangeModel pizzaChangeModel)
        {
            if (ModelState.IsValid)
            {
                _iPizzaService.UpdatePizza(pizzaChangeModel);

                var msg = new
                {
                    message = "Изменения пиццы внесены"
                };
                return Ok(msg);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Неверные входные данные",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }
    }
}
