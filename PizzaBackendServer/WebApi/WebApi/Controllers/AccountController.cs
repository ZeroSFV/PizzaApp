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

namespace Dinner.Controllers
{
    [Produces("application/json")]
    [Route("api/account")]
    public class AccountController : ControllerBase
    {
        private readonly IAccountService _iAccountService;
        public AccountController(IAccountService iAccountService)
        {
            _iAccountService = iAccountService;
        }

        [HttpPost]
        [Route("signUp")]
        public async Task<IActionResult> SignUp([FromBody] SignUpModel user)
        {
            if (ModelState.IsValid)
            {
                if (_iAccountService.CheckUserByEmail(user.Email) != true)
                {
                    if (user.Password.Length <= 30 && user.Password.Length >= 6)
                    {
                        if (ModelState.IsValid)
                        {
                            await _iAccountService.CreateUser(user);
                            var msg = new
                            {
                                message = "Регистрация прошла успешно! Ссылка с подтверждением отправлена по вашему адресу электронной почты!"
                            };
                            return Ok(msg);
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
                    message = "Не удалось добавить пользователя",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpPost]
        [Route("signIn")]
        public async Task<IActionResult> SignIn([FromBody] SignInModel model)
        {
            UserModel AuthenticateUser(string email, string password)
            {
                return _iAccountService.GetUserByEmailAndPassword(email, password);
            }

            var user = AuthenticateUser(model.Email, model.Password);

            if (user != null)
            {
                //Генерация токена
                var token = TokenService.GenerateJWT(user);
                var refreshToken = TokenService.GenerateRefreshToken();
                user.RefreshToken = refreshToken;
                _iAccountService.UpdateUser(user);
                TokenModel tokenModel = new TokenModel(refreshToken, token);
                return Ok(tokenModel);
            }
            else
            {
                return Unauthorized();
            }
        }

        [HttpPut]
        [Route("resetpassword")]
        public async Task<IActionResult> ResetPassword([FromBody] string email)
        {
            if (_iAccountService.CheckUserByEmail(email) == true)
            {
                await _iAccountService.ResetPasswordOfUser(email);
                return Ok("Новый пароль отправлен на электронную почту!");
            }
            else
            {
                var errorMsg = new
                {
                    message = "Данного пользователя не существует!",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpPut]
        [Route("changepassword")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordModel changePasswordModel)
        {
            if (changePasswordModel.NewPassword.Length <= 30 && changePasswordModel.NewPassword.Length >= 6)
            {
                bool correctPassword = _iAccountService.ChangePasswordOfUser(changePasswordModel);
                if (correctPassword == true)
                    return Ok("Ваш пароль изменён!");
                else
                {
                    var errorMsg = new
                    {
                        message = "Старый пароль был введен неправильно!",
                        error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                    };
                    return BadRequest(errorMsg);
                }
            }
            else
            {
                var errorMsg = new
                {
                    message = "Длина пароля должна быть больше 5 и меньше 31 символа",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }

        }

    }
}
