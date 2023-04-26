using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.Data;

namespace BLL.Models
{
    public class OrderModel
    {
        public int Id { get; set; }
        public DateTime CreationTime { get; set; }
        public DateTime? FinishedTime { get; set; }
        public decimal Price { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
        public string ClientName { get; set; }
        public string PayingType { get; set; }
        public decimal? Change { get; set; }
        public int ClientId { get; set; }
        public int? WorkerId { get; set; }
        public int? CourierId { get; set; }
        public int StatusId { get; set; }
        public ObservableCollection<OrderStringModel> OrderLines { get; set; }
        public List<int> OrderStringIds { get; set; }
        public StatusModel Status { get; set; }
        public OrderModel() { }

        public OrderModel(Order o)
        {
            Id = o.Id;
            CreationTime = o.CreationTime;
            FinishedTime = o.FinishedTime;
            Price = o.Price;
            Address = o.Address;
            PhoneNumber = o.PhoneNumber;
            ClientName = o.ClientName;
            PayingType = o.PayingType;
            Change = o.Change;
            ClientId = o.ClientId;
            WorkerId = o.WorkerId;
            CourierId = o.CourierId;
            StatusId = o.StatusId;
            Status = new StatusModel(o.Status);
            OrderStringIds = o.OrderStrings.Select(i => i.Id).ToList();
            OrderLines = new ObservableCollection<OrderStringModel>();
            foreach (var os in o.OrderStrings)
            {
                OrderLines.Add(new OrderStringModel(os));
            }
        }
    }
}
