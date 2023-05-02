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
        public IActionResult GetUserBaskets(int userId)
        {
            try 
            { 
                List<BasketModel> allUserBaskets = _iBasketService.GetAllBasketsByUserId(userId);
                if (allUserBaskets != null)
                    return new ObjectResult(allUserBaskets);
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "У данного пользователя пустая корзина!" });                
            }
            catch (Exception e) 
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpDelete("deleteBasket/{basketId}")]
        public IActionResult DeleteBasket(int basketId)
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
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные" });
            }
        }

        [HttpPut("updateBasket")]
        public IActionResult updateBasket([FromBody] BasketModel basketModel)
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
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные" });
            }
        }

        [HttpPost("createBasket")]
        public IActionResult CreateBasket([FromBody] CreateBasketModel createBasketModel)
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
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные" });
            }
        }
    }
}
