using Microsoft.AspNetCore.Mvc;
using BLL.Interfaces;
using System.IdentityModel.Tokens.Jwt;
using BLL.Services;
using BLL.Models;
using System.Net.Http.Headers;

namespace WebApi.Controllers
{
    [ApiController]
    [Route("api/refreshToken")]
    public class RefreshTokenController : Controller
    {
        private readonly IUserService _iUserService;
        public RefreshTokenController(IUserService iUserService)
        {
            _iUserService = iUserService;
        }

        [HttpPost]
        public IActionResult RefreshToken([FromBody] TokenModel tokenModel)
        {
            if (ModelState.IsValid)
            {
                var tokenHandler = new JwtSecurityTokenHandler();
                var jwt = tokenHandler.ReadJwtToken(tokenModel.JWTtoken);
                var userId = Int32.Parse(jwt.Claims.First(claim => claim.Type == JwtRegisteredClaimNames.Sub).Value);

                var user = _iUserService.GetUserById(userId);
                if (user != null)
                {
                    if (user.RefreshToken != tokenModel.RefreshToken)
                    {
                        return BadRequest(new ErrorResponseModel { Status = 500, Description = "Токены не совпадают" });
                    }

                    var newJwtToken = TokenService.GenerateJWT(user);
                    return Ok(newJwtToken);
                }
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "По данному токену не удалось найти пользователя, чтобы обновить токен!" });
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Ошибка обработки запроса" });
            }
        }
    }
}
