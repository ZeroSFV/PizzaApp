using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Cryptography;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;

namespace BLL.Services
{
    public class HashPasswordService
    {
        public static string HashUserPassword(string password, byte[] salt = null, bool hashOnly = false)
        {
            if (salt == null)
            {
                salt = new byte[128 / 8];
                using (var rng = RandomNumberGenerator.Create())
                {
                    rng.GetBytes(salt);
                }
            }
            string hashedPassword = Convert.ToBase64String(KeyDerivation.Pbkdf2(
                password: password,
                salt: salt,
                prf: KeyDerivationPrf.HMACSHA256,
                iterationCount: 10000,
                numBytesRequested: 256 / 8));
            if (hashOnly == true)
            {
                return hashedPassword;
            }
            return $"{hashedPassword}:{Convert.ToBase64String(salt)}";
        }
        public static bool VerifyUserPassword(string password, string hashedPassword)
        {
            var passwordAndHash = hashedPassword.Split(':');
            if (passwordAndHash == null || passwordAndHash.Length != 2)
                return false;
            var salt = Convert.FromBase64String(passwordAndHash[1]);
            if (salt == null)
                return false;
            var hashOfpasswordToCheck = HashUserPassword(password, salt, true);
            if (String.Compare(passwordAndHash[0], hashOfpasswordToCheck) == 0)
            {
                return true;
            }
            return false;
        }
    }
}
