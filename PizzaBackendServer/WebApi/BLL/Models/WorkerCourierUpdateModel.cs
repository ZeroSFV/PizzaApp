using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class WorkerCourierUpdateModel
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Phones { get; set; }
        public string? Passport { get; set; }
        public WorkerCourierUpdateModel() { }

        public WorkerCourierUpdateModel(int id, string name, string phones, string passport)
        {
            Id = id;
            Name = name;
            Phones = phones;
            Passport = passport;
        }
    }
}
