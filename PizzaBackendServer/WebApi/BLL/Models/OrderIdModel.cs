using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Interfaces;
using DAL.Data;

namespace BLL.Models
{
    public class OrderIdModel
    {
        public int Id { get; set; }
        public OrderIdModel() { }
        public OrderIdModel(int id)
        {
            Id = id;
        }
    }
}
