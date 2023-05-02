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
using Microsoft.AspNetCore.Authorization;
using System.Data;

namespace WebApi.Controllers
{
    [ApiController]
    [Route("api/admin")]
    public class AdminController : ControllerBase
    {
        private readonly IUserService _iUserService;
        private readonly IAccountService _iAccountService;
        public AdminController(IUserService iUserService, IAccountService iAccountService)
        {
            _iUserService = iUserService;
            _iAccountService = iAccountService;
        }

        [HttpGet]
        public IActionResult GetAllUsers()
        {
            try
            {
                List<UserInfoModel> allUsers = _iUserService.GetAllUsers();
                if (allUsers != null)
                {
                    return new ObjectResult(allUsers);
                }
                else
                {
                    return BadRequest(new ErrorResponseModel { Status = 500, Description = "Список пользователей получить не удалось!"});
                }
            }
            catch (Exception e) 
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("getUnapprovedUsers")]
        public IActionResult GetAllUnapprovedUsers()
        {
            try
            {
                List<UserInfoModel> allUnapprovedUsers = _iUserService.GetAllUnapprovedUser();
                if (allUnapprovedUsers != null)
                {
                    return new ObjectResult(allUnapprovedUsers);
                }
                else
                {
                    return BadRequest(new ErrorResponseModel { Status = 500, Description = "Список неподтвержденных пользователей получить не удалось!" });
                }
            }
            catch (Exception e) 
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("getWorkers")]
        public IActionResult GetAllWokrers()
        {
            try
            {
                List<UserInfoModel> allWorkers = _iUserService.GetAllWorkers();
                if (allWorkers != null)
                {
                    return new ObjectResult(allWorkers);
                }
                else
                {
                    return BadRequest(new ErrorResponseModel { Status = 500, Description = "Список работников получить не удалось!" });
                }
            }
            catch (Exception e)
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("getCouriers")]
        public IActionResult GetAllCouriers()
        {
            try
            {
                List<UserInfoModel> allCouriers = _iUserService.GetAllCouriers();
                if (allCouriers != null)
                {
                    return new ObjectResult(allCouriers);
                }
                else
                {
                    return BadRequest(new ErrorResponseModel { Status = 500, Description = "Список курьеров получить не удалось!" });
                }
            }
            catch(Exception e) 
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpPost]
        [Route("signUpNewWorkerCourier")]
        public IActionResult SignUp([FromBody] SignUpWorkerCourierModel user)
        {
            if (ModelState.IsValid)
            {
                if (user.Role == "worker" || user.Role == "courier")
                {
                    if (_iAccountService.CheckUserByEmail(user.Email) != true)
                    {
                        if (user.Password.Length <= 30 && user.Password.Length >= 6)
                        {
                            _iUserService.CreateUser(user);
                            return Ok("Новый пользователь добавлен!"); 
                        }
                        else
                        {
                            return BadRequest(new ErrorResponseModel { Status = 500, Description = "Длина пароля должна быть от 6 до 30 символов!" });
                        }
                    }
                    else
                    {
                        return BadRequest(new ErrorResponseModel { Status = 500, Description = "Аккаунт с данной электронной почтой уже существует!" });
                    }
                }
                else
                {
                    return BadRequest(new ErrorResponseModel { Status = 500, Description = "Вы должны создать либо курьера, либо работника!" });
                }
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Не удалось добавить пользователя" });
            }
        }

        [HttpPut("approveUser/{userId}")]
        public IActionResult ApproveUser([FromBody]int userId)
        {
            if (ModelState.IsValid)
            {
                _iUserService.ApproveUser(userId);

                var msg = new
                {
                    message = "Аккаунт пользователя был подтвержден"
                };
                return Ok(msg);
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные" });
            }
        }

        [HttpDelete("deleleUser/{userId}")]
        public IActionResult DeleteUser([FromBody]int userId)
        {
            if (ModelState.IsValid)
            {
                var user = _iUserService.GetUserInfo(userId);
                if (user != null)
                {
                    if (user.Role != "admin")
                    {
                        _iUserService.DeleteUser(userId);

                        var msg = new
                        {
                            message = "Пользователь был удален"
                        };
                        return Ok(msg);
                    }
                    else
                    {
                        return BadRequest(new ErrorResponseModel { Status = 500, Description = "Нельзя удалить администратора" });
                    }
                }
                else
                {
                    return BadRequest(new ErrorResponseModel { Status = 500, Description = "Такого пользователя нет!" });
                }
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные" });
            }
        }
    }
}
