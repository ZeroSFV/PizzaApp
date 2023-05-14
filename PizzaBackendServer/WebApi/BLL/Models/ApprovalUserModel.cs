using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class ApprovalUserModel
    {
        public int Id { get; set; }
        public string ApprovalCode { get; set; }
        public ApprovalUserModel() { }

        public ApprovalUserModel(int id, string approvalCode)
        {
            Id = id;
            ApprovalCode = approvalCode;
        }
    }
}