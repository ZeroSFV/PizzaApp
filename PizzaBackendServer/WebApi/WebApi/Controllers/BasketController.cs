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
using BLL.Services;

namespace WebApi.Controllers
{
    [ApiController]
    [Route("api/basket")]
    public class BasketController : ControllerBase
    {
        private readonly IBasketService _iBasketService;
        public BasketController(IBasketService iBasketService)
        {
            _iBasketService = iBasketService;
        }

        [HttpGet("userBaskets/{userId}")]
        public async Task<IActionResult> GetUserBaskets(int userId)
        {
            if (ModelState.IsValid)
            {
                List<BasketModel> allUserBaskets = _iBasketService.GetAllBasketsByUserId(userId);
                return new ObjectResult(allUserBaskets);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения корзины пользователя произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpDelete("deleteBasket/{basketId}")]
        public async Task<IActionResult> DeleteBasket(int basketId)
        {
            if (ModelState.IsValid)
            {
                _iBasketService.DeleteBasket(basketId);

                var msg = new
                {
                    message = "Строчка корзины была удалена"
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

        [HttpPut("updateBasket")]
        public async Task<IActionResult> updateBasket([FromBody] BasketModel basketModel)
        {
            if (ModelState.IsValid)
            {
                _iBasketService.UpdateBasket(basketModel);
                var msg = new
                {
                    message = "Изменения корзины были внесены"
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

        [HttpPost("createBasket")]
        public async Task<IActionResult> CreateBasket([FromBody] CreateBasketModel createBasketModel)
        {
            if (ModelState.IsValid)
            {
                _iBasketService.CreateBasket(createBasketModel);
                var msg = new
                {
                    message = "Пицца была добавлена в корзину"
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
