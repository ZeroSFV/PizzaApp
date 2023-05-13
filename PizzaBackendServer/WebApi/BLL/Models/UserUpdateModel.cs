using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class UserUpdateModel
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Phones { get; set; }
        public UserUpdateModel() { }

        public UserUpdateModel(int id, string name, string phones)
        {
            Id = id;
            Name = name;
            Phones = phones;
        }
    }
}
