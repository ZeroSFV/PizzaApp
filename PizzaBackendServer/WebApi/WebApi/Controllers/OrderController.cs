using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using BLL.Models;
using BLL.Interfaces;
using BLL;
using Microsoft.AspNetCore.Authorization;
using BLL.Services;

namespace WebApi.Controllers
{
    [ApiController]
    [Route("api/order")]
    public class OrderController : ControllerBase
    {
        private readonly IOrderService _iOrderService;
        public OrderController(IOrderService iOrderService)
        {
            _iOrderService = iOrderService;
        }

        [HttpGet]
        public IActionResult GetAllOrders()
        {
            try
            {
                List<OrderModel> allOrders = _iOrderService.GetAllOrders();
                if (allOrders != null)
                {
                    return new ObjectResult(allOrders);
                }
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "Получить список заказов не удалось" });
            }
            catch (Exception e) 
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("userOrder/{userId}")]
        public IActionResult GetUserOrders(int userId)
        {
            try
            {
                List<OrderModel> userOrders = _iOrderService.GetOrdersOfUser(userId);
                if (userOrders != null)
                {
                    return new ObjectResult(userOrders);
                }
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "У данного клиента нет заказов" });
            }
            catch (Exception e)
            {
                return BadRequest(new ErrorResponseModel { Status=500, Description = e.Message });
            }
        }

        [HttpGet("workerOrder/{workerId}")]
        public IActionResult GetWorkerOrders(int workerId)
        {
            try
            {
                List<OrderModel> workerOrders = _iOrderService.GetOrdersOfWorker(workerId);
                if (workerOrders != null)
                {
                    return new ObjectResult(workerOrders);
                }
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "Заказов с участием данного работника не существует" }); 
                
            }
            catch (Exception e)
            { 
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("courierOrder/{courierId}")]
        public IActionResult GetCourierOrders(int courierId)
        {
            try
            {
                List<OrderModel> courierOrders = _iOrderService.GetOrdersOfCourier(courierId);
                if (courierOrders != null)
                    return new ObjectResult(courierOrders);
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "Заказов с участием данного курьера не существует" });
            }
            catch (Exception e)
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("userActiveOrder/{userId}")]
        public IActionResult GetUserActiveOrder(int userId)
        {
            try
            { 
                OrderModel userActiveOrder = _iOrderService.GetActiveOrderByUserId(userId);
                if (userActiveOrder != null)
                    return new ObjectResult(userActiveOrder);
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "У данного клиента нет активного заказа в данный момент!" });
            }
            catch (Exception e)
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("workerActiveOrder/{workerId}")]
        public IActionResult GetWorkerActiveOrder(int workerId)
        {
            try
            { 
                OrderModel workerActiveOrder = _iOrderService.GetActiveOrderOfWorker(workerId);
                if (workerActiveOrder != null)
                    return new ObjectResult(workerActiveOrder);
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "Активных заказов у данного работника пиццерии нет!" });
            }
            catch (Exception e)
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("courierActiveOrder/{courierId}")]
        public IActionResult GetCourierActiveOrders(int courierId)
        {
            try
            {
                List<OrderModel> courierActiveOrders = _iOrderService.GetActiveOrdersOfCourier(courierId);
                if (courierActiveOrders != null)
                    return new ObjectResult(courierActiveOrders);
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "Активных заказов у данного курьера нет!" });
            }
            catch (Exception e) 
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("unacceptedWorkerOrders")]
        public IActionResult GetUnacceptedByWorkerOrders()
        {
            try
            {
                List<OrderModel> workerUnacceptedOrders = _iOrderService.GetUnacceptedByWorkerOrders();
                if (workerUnacceptedOrders != null)
                    return new ObjectResult(workerUnacceptedOrders);
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "Заказов со статусом 'Оформлен' нет в данный момент!"});
            }
            catch (Exception e)
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpGet("unacceptedCourierOrders")]
        public IActionResult GetUnacceptedByCourierOrders()
        {
            try 
            {
                List<OrderModel> courierUnacceptedOrders = _iOrderService.GetUnacceptedByCourierOrders();
                if (courierUnacceptedOrders != null)
                    return new ObjectResult(courierUnacceptedOrders);
                else return BadRequest(new ErrorResponseModel { Status = 500, Description = "Заказов со статусом 'Комплектуется' нет в данный момент!" });
            }
            catch (Exception e)
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = e.Message });
            }
        }

        [HttpPut("cancelOrder")]
        public IActionResult CancelOrder([FromBody] int orderId)
        {
            if (ModelState.IsValid)
            {
                if (_iOrderService.CheckIfOrderCanBeCancelled(orderId) == true)
                {
                    _iOrderService.CancelThisOrder(orderId);
                    var msg = new
                    {
                        message = "Заказ был отменён"
                    };
                    return Ok(msg);
                }
                else
                {
                    return BadRequest(new ErrorResponseModel { Status = 500, Description = "Данный заказ уже нельзя отменить!" });
                }
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные!" });
            }
        }

        [HttpPut("toNextStatus")]
        public IActionResult ToNextStatus([FromBody] int orderId)
        {
            if (ModelState.IsValid)
            {
                _iOrderService.ChangeToNextStatus(orderId);
                var msg = new
                {
                    message = "Заказ был переведен в следующий статус"
                };
                return Ok(msg);
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные!" });
            }
        }

        [HttpPut("acceptOrderByWorker")]
        public IActionResult AcceptOrderByWorker([FromBody] AcceptOrderModel acceptOrderWorker)
        {
            if (ModelState.IsValid)
            {
                _iOrderService.AcceptOrderWorker(acceptOrderWorker.WorkerId, acceptOrderWorker.OrderId);
                var msg = new
                {
                    message = "Заказ был принят"
                };
                return Ok(msg);
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные!" });
            }
        }

        [HttpPut("acceptOrderByCourier")]
        public IActionResult AcceptOrderByCourier([FromBody] AcceptOrderModel acceptOrderCourier)
        {
            if (ModelState.IsValid)
            {
                _iOrderService.AcceptOrderCourier(acceptOrderCourier.CourierId, acceptOrderCourier.OrderId);
                var msg = new
                {
                    message = "Заказ был принят"
                };
                return Ok(msg);
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные!" });
            }
        }

        [HttpPost("makeOrder")]
        public IActionResult MakeOrder([FromBody] MakeOrderModel makeOrder)
        {
            if (ModelState.IsValid)
            {
                _iOrderService.MakeOrder(makeOrder);
                var msg = new
                {
                    message = "Заказ был создан"
                };
                return Ok(msg);
            }
            else
            {
                return BadRequest(new ErrorResponseModel { Status = 500, Description = "Неверные входные данные!" });
            }
        }
    }
}
