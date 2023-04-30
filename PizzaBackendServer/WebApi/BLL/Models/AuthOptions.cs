using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace BLL.Models
{
    public class AuthOptions
    {
        public const string ISSUER = "PizzerBackEnd";
        public const string AUDIENCE = "PizzerMobile";
        const string KEY = "nuichtosudapisatznakvoprosa";
        public const int LIFETIME = 6000000; //Не знаю, какое время жизни ставить
        public static SymmetricSecurityKey GetSymmetricSecurityKey()
        {
            return new SymmetricSecurityKey(Encoding.ASCII.GetBytes(KEY));
        }
    }
}