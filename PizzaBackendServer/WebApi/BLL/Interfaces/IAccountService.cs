using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Models;

namespace BLL.Interfaces
{
    public interface IAccountService
    {
        bool CheckUserByEmail(string email);
        void CreateUser(SignUpModel signUpModel);
        UserModel GetUserByEmailAndPassword(string email, string password);
        void UpdateUser(UserModel userModel);
        bool ChangePasswordOfUser(ChangePasswordModel changePasswordModel);
        Task ResetPasswordOfUser(string email);
    }
}
