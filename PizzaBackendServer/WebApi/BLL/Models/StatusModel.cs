using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class StatusModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public StatusModel() { }

        public StatusModel(Status st) 
        {
            Id = st.Id;
            Name = st.Name;
        }
    }
}
