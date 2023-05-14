using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Models
{
    public class ResetPasswordModel
    {
        public string Email { get; set; }
        public ResetPasswordModel() { }

        public ResetPasswordModel(string email)
        {
           Email = email;
        }
    }
}
