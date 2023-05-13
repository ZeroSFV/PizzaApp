using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using BLL.Models;
using BLL.Interfaces;
using DAL.Data;
using Microsoft.Extensions.Options;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using BLL.Services;

namespace WebApi.Controllers
{
    [ApiController]
    [Route("api/user")]
    public class UserController : ControllerBase
    {
        private readonly IUserService _iUserService;
        public UserController(IUserService iUserService)
        {
            _iUserService = iUserService;
        }

        [HttpGet]
        public IActionResult GetUserData(string token)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var jwt = tokenHandler.ReadJwtToken(token);
            int userId = Int32.Parse(jwt.Claims.First(claim => claim.Type == JwtRegisteredClaimNames.Sub).Value);
            var userInfoModel = _iUserService.GetUserInfo(userId);
            if (userInfoModel != null) 
            {
                return Ok(userInfoModel);
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Не удалось найти пользователя по заданому токену" });
            }
        }

        [HttpPut("updateClient")]
        public IActionResult UpdateClient([FromBody] UserUpdateModel userUpdateModel)
        {
            if (ModelState.IsValid)
            {
                _iUserService.UpdateUser(userUpdateModel);
                var msg = new
                {
                    message = "Пользователь изменён"
                };
                return Ok(msg);
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные" });
            }
        }

        [HttpPut("updateWorkerCourier")]
        public IActionResult UpdateWorkerCourier([FromBody] WorkerCourierUpdateModel workerCourierUpdateModel)
        {
            if (ModelState.IsValid)
            {
                _iUserService.UpdateWorkerCourier(workerCourierUpdateModel);
                var msg = new
                {
                    message = "Пользователь изменён"
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
