﻿using System;
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
        public List<BasketModel> Baskets { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
        public string ClientName { get; set; }
        public string PayingType { get; set; }
        public decimal? Change { get; set; }
        public MakeOrderModel() { }

        public MakeOrderModel(int clientId, List<BasketModel> baskets, string address, string phoneNumber, string clientName, string payingType, decimal? change)
        {
            ClientId = clientId;
            Baskets = baskets;
            Address = address;
            PhoneNumber = phoneNumber;
            ClientName = clientName;
            PayingType = payingType;
            Change = change;
        }
    }
}
