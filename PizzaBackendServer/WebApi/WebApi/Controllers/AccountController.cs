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
        public IActionResult SignUp([FromBody] SignUpModel user)
        {
            if (ModelState.IsValid)
            {
                if (_iAccountService.CheckUserByEmail(user.Email) != true)
                {
                    if (user.Password.Length <= 30 && user.Password.Length >= 6)
                    {
                        if (ModelState.IsValid)
                        {
                            _iAccountService.CreateUser(user);
                            var msg = new
                            {
                                message = "Регистрация прошла успешно! Ссылка с подтверждением отправлена по вашему адресу электронной почты!"
                            };
                            return Ok(msg);
                        }
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
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Не удалось добавить пользователя" });
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Не удалось добавить пользователя" });
            }
        }

        [HttpPost]
        [Route("signIn")]
        public IActionResult SignIn([FromBody] SignInModel model)
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
                return Unauthorized(new ErrorResponseModel { Status = 400, Description = "Неправильный пароль или электронная почта" });
            }
        }

        [HttpPut]
        [Route("resetpassword")]
        public IActionResult ResetPassword([FromBody] string email)
        {
            if (_iAccountService.CheckUserByEmail(email) == true)
            {
                _iAccountService.ResetPasswordOfUser(email);
                return Ok("Новый пароль отправлен на электронную почту!");
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Данного пользователя не существует" });
            }
        }

        [HttpPut]
        [Route("changepassword")]
        public IActionResult ChangePassword([FromBody] ChangePasswordModel changePasswordModel)
        {
            if (changePasswordModel.NewPassword.Length <= 30 && changePasswordModel.NewPassword.Length >= 6)
            {
                bool correctPassword = _iAccountService.ChangePasswordOfUser(changePasswordModel);
                if (correctPassword == true)
                    return Ok("Ваш пароль изменён!");
                else
                {
                    return BadRequest(new ErrorResponseModel { Status = 500, Description = "Старый пароль введён не правильно!" });
                }
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Длина пароля должна быть больше 5 и меньше 31 символа" });
            }
        }

    }
}
