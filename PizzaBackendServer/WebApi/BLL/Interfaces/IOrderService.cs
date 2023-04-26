using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Models;

namespace BLL.Interfaces
{
    public interface IOrderService
    {
        List<OrderModel> GetAllOrders();
        List<OrderModel> GetOrdersOfUser(int userId);
        List<OrderModel> GetOrdersOfWorker(int workerId);
        List<OrderModel> GetOrdersOfCourier(int courierId);
        OrderModel GetActiveOrderByUserId(int userId);
        bool CheckIfOrderCanBeCancelled(int orderId);
        void CancelThisOrder(int orderId);
        void AcceptOrderWorker(int workerId, int orderId);
        void AcceptOrderCourier(int courierId, int orderId);
        void ChangeToNextStatus(int orderId);
        OrderModel GetActiveOrderOfWorker(int workerId);
        List<OrderModel> GetActiveOrdersOfCourier(int courierId);
        List<OrderModel> GetUnacceptedByWorkerOrders();
        List<OrderModel> GetUnacceptedByCourierOrders();
        int MakeOrder(MakeOrderModel makeOrderModel);

    }
}
