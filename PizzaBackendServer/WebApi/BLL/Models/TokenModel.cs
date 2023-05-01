using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace BLL.Models
{
    public class TokenModel
    {
        public string RefreshToken { get; set; }
        public string JWTtoken { get; set; }

        public TokenModel() { }

        public TokenModel(string refreshToken, string jwttoken)
        {
            RefreshToken = refreshToken;
            JWTtoken = jwttoken;
        }

    }
}
