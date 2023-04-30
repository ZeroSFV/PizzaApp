using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace BLL.Models
{
    public class CredentialsModel
    {
        public string Email { get; set; }
        public string Password { get; set; }

        public CredentialsModel() { }
        public CredentialsModel(string email, string password)
        {
            Email = email;
            Password = password;
        }
    }
}
