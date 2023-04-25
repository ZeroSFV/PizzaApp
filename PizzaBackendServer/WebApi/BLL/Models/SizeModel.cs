using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class SizeModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public SizeModel() { }  

        public SizeModel(Size s) 
        {
            Id = s.Id;
            s.Name = s.Name;
        }
        
    }
}
