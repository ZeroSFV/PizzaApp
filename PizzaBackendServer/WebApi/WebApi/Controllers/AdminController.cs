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
        public async Task<IActionResult> GetAllUsers()
        {
            if (ModelState.IsValid)
            {
                List<UserInfoModel> allUsers = _iUserService.GetAllUsers();
                if (allUsers != null)
                {
                    return new ObjectResult(allUsers);
                }
                else
                {
                    var errorMsg = new
                    {
                        message = "Список пользователей получить не удалось!",
                        error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                    };
                    return BadRequest(errorMsg);
                }
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

        [HttpGet("getUnapprovedUsers")]
        public async Task<IActionResult> GetAllUnapprovedUsers()
        {
            if (ModelState.IsValid)
            {
                List<UserInfoModel> allUnapprovedUsers = _iUserService.GetAllUnapprovedUser();
                if (allUnapprovedUsers != null)
                {
                    return new ObjectResult(allUnapprovedUsers);
                }
                else
                {
                    var errorMsg = new
                    {
                        message = "Список неподтвержденных пользователей получить не удалось!",
                        error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                    };
                    return BadRequest(errorMsg);
                }
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

        [HttpGet("getWorkers")]
        public async Task<IActionResult> GetAllWokrers()
        {
            if (ModelState.IsValid)
            {
                List<UserInfoModel> allWorkers = _iUserService.GetAllWorkers();
                if (allWorkers != null)
                {
                    return new ObjectResult(allWorkers);
                }
                else
                {
                    var errorMsg = new
                    {
                        message = "Список работников получить не удалось!",
                        error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                    };
                    return BadRequest(errorMsg);
                }
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

        [HttpGet("getCouriers")]
        public async Task<IActionResult> GetAllCouriers()
        {
            if (ModelState.IsValid)
            {
                List<UserInfoModel> allCouriers = _iUserService.GetAllCouriers();
                if (allCouriers != null)
                {
                    return new ObjectResult(allCouriers);
                }
                else
                {
                    var errorMsg = new
                    {
                        message = "Список курьеров получить не удалось!",
                        error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                    };
                    return BadRequest(errorMsg);
                }
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

        [HttpPost]
        [Route("signUpNewWorkerCourier")]
        public async Task<IActionResult> SignUp([FromBody] SignUpWorkerCourierModel user)
        {
            if (ModelState.IsValid)
            {
                if (user.Role == "worker" || user.Role == "courier")
                {
                    if (_iAccountService.CheckUserByEmail(user.Email) != true)
                    {
                        if (user.Password.Length <= 30 && user.Password.Length >= 6)
                        {
                            if (ModelState.IsValid)
                            {
                                await _iUserService.CreateUser(user);
                                return Ok("Новый пользователь добавлен!");
                            }
                        }
                        else
                        {
                            var errorMsg = new
                            {
                                message = "Длина пароля должна быть от 6 до 30 символов!",
                                error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                            };
                            return BadRequest(errorMsg);
                        }
                    }
                    else
                    {
                        var errorMsg = new
                        {
                            message = "Аккаунт с данной электронной почтой уже существует!",
                            error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                        };
                        return BadRequest(errorMsg);
                    }
                    return BadRequest("Не удалось добавить пользователя");
                }
                else
                {
                    var errorMsg = new
                    {
                        message = "Вы должны создать либо курьера, либо работника!",
                        error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                    };
                    return BadRequest(errorMsg);
                }
            }
            else
            {
                var errorMsg = new
                {
                    message = "Не удалось добавить пользователя",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpPut("approveUser/{userId}")]
        public async Task<IActionResult> ApproveUser(int userId)
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
                var errorMsg = new
                {
                    message = "Неверные входные данные",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpDelete("deleleUser/{userId}")]
        public async Task<IActionResult> DeleteUser(int userId)
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
                        var errorMsg = new
                        {
                            message = "Нельзя удалить администратора",
                            error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                        };
                        return BadRequest(errorMsg);
                    }
                }
                else
                {
                    var errorMsg = new
                    {
                        message = "Такого пользователя нет!",
                        error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                    };
                    return BadRequest(errorMsg);
                }
            }
            else
            {
                return BadRequest();
            }
        }
    }
}
