using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class MakeOrderModel
    {
        public int ClientId { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
        public string ClientName { get; set; }
        public string PayingType { get; set; }
        public DateTime? PredictedTime { get; set; }
        public decimal? Change { get; set; }
        public int? UsedBonuses { get; set; }
        public int GivenBonuses { get; set; }
        public string? Comment { get; set; }


        public MakeOrderModel() { }

        public MakeOrderModel(int clientId,  string address, string phoneNumber, string clientName, string payingType, decimal? change, DateTime? predictedTime, int? usedBonuses, int givenBonuses, string? comment)
        {
            ClientId = clientId;
            Address = address;
            PhoneNumber = phoneNumber;
            ClientName = clientName;
            PayingType = payingType;
            Change = change;
            PredictedTime = predictedTime;
            UsedBonuses = usedBonuses;
            GivenBonuses = givenBonuses;
            Comment = comment;
        }
    }
}
