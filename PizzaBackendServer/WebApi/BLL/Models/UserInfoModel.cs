using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class UserInfoModel
    {
        public int Id { get; set; }
        public string Email { get; set; } = null!;
        public string Name { get; set; } = null!;
        public string Role { get; set; } = null!;
        public bool IsApproved { get; set; }
        public string Phone { get; set; }
        public int? Bonuses { get; set; }
        public string? Passport { get; set; }
        public string? ApprovalCode { get; set; }

        public UserInfoModel() { }
        public UserInfoModel(UserModel u)
        {
            Id = u.Id;
            Email = u.Email;
            Name = u.Name;
            Role = u.Role;
            IsApproved = u.IsApproved;
            Phone = u.Phone;
            Passport = u.Passport;
            Bonuses = u.Bonuses;
            ApprovalCode = u.ApprovalCode;
        }
    }
}