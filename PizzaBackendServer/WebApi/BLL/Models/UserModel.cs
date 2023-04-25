using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class UserModel
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }
        public string Phone { get; set; }
        public string? Passport { get; set; }
        public int? Bonuses { get; set; }
        public string Role { get; set; }
        public bool IsApproved { get; set; }
        public string? RefreshToken { get; set; }
        public UserModel() { }

        public UserModel(User u)
        {
            Id = u.Id;
            Email = u.Email;
            Password = u.Password;
            Name = u.Name;
            Phone = u.Phone;
            Passport = u.Passport;
            Bonuses = u.Bonuses;
            Role = u.Role;
            IsApproved = !(u.IsApproved == 0);
            RefreshToken = u.RefreshToken;
        }
    }
}
