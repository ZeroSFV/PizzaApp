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
        public async Task<IActionResult> GetAllOrders()
        {
            if (ModelState.IsValid)
            {
                List<OrderModel> allOrders = _iOrderService.GetAllOrders();
                return new ObjectResult(allOrders);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения всех заказов произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpGet("userOrder/{userId}")]
        public async Task<IActionResult> GetUserOrders(int userId)
        {
            if (ModelState.IsValid)
            {
                List<OrderModel> userOrders = _iOrderService.GetOrdersOfUser(userId);
                return new ObjectResult(userOrders);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения заказов пользователя произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpGet("workerOrder/{workerId}")]
        public async Task<IActionResult> GetWorkerOrders(int workerId)
        {
            if (ModelState.IsValid)
            {
                List<OrderModel> workerOrders = _iOrderService.GetOrdersOfWorker(workerId);
                return new ObjectResult(workerOrders);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения заказов работника произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpGet("courierOrder/{courierId}")]
        public async Task<IActionResult> GetCourierOrders(int courierId)
        {
            if (ModelState.IsValid)
            {
                List<OrderModel> courierOrders = _iOrderService.GetOrdersOfCourier(courierId);
                return new ObjectResult(courierOrders);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения заказов работника произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpGet("userActiveOrder/{userId}")]
        public async Task<IActionResult> GetUserActiveOrder(int userId)
        {
            if (ModelState.IsValid)
            {
                OrderModel userActiveOrder = _iOrderService.GetActiveOrderByUserId(userId);
                return new ObjectResult(userActiveOrder);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения активного заказа пользователя произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpGet("workerActiveOrder/{workerId}")]
        public async Task<IActionResult> GetWorkerActiveOrder(int workerId)
        {
            if (ModelState.IsValid)
            {
                OrderModel workerActiveOrder = _iOrderService.GetActiveOrderOfWorker(workerId);
                return new ObjectResult(workerActiveOrder);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения активного заказа работника произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpGet("courierActiveOrder/{courierId}")]
        public async Task<IActionResult> GetCourierActiveOrders(int courierId)
        {
            if (ModelState.IsValid)
            {
                List<OrderModel> courierActiveOrders = _iOrderService.GetActiveOrdersOfCourier(courierId);
                return new ObjectResult(courierActiveOrders);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения активного заказов курьера произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpGet("unacceptedWorkerOrders")]
        public async Task<IActionResult> GetUnacceptedByWorkerOrders()
        {
            if (ModelState.IsValid)
            {
                List<OrderModel> workerUnacceptedOrders = _iOrderService.GetUnacceptedByWorkerOrders();
                return new ObjectResult(workerUnacceptedOrders);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения непринятых заказов работником произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpGet("unacceptedCourierOrders")]
        public async Task<IActionResult> GetUnacceptedByCourierOrders()
        {
            if (ModelState.IsValid)
            {
                List<OrderModel> courierUnacceptedOrders = _iOrderService.GetUnacceptedByCourierOrders();
                return new ObjectResult(courierUnacceptedOrders);
            }
            else
            {
                var errorMsg = new
                {
                    message = "Во время получения непринятых заказов курьером произошла ошибка",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpPut("cancelOrder")]
        public async Task<IActionResult> CancelOrder([FromBody] int orderId)
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
                    var errorMsg = new
                    {
                        message = "Данный заказ уже нельзя отменить",
                        error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                    };
                    return BadRequest(errorMsg);
                }
            }
            else
            {
                var errorMsg = new
                {
                    message = "Неверные входные данные",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpPut("toNextStatus")]
        public async Task<IActionResult> ToNextStatus([FromBody] int orderId)
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
                var errorMsg = new
                {
                    message = "Неверные входные данные",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpPut("acceptOrderByWorker")]
        public async Task<IActionResult> AcceptOrderByWorker([FromBody] AcceptOrderModel acceptOrderWorker)
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
                var errorMsg = new
                {
                    message = "Неверные входные данные",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpPut("acceptOrderByCourier")]
        public async Task<IActionResult> AcceptOrderByCourier([FromBody] AcceptOrderModel acceptOrderCourier)
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
                var errorMsg = new
                {
                    message = "Неверные входные данные",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }

        [HttpPost("makeOrder")]
        public async Task<IActionResult> MakeOrder([FromBody] MakeOrderModel makeOrder)
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
                var errorMsg = new
                {
                    message = "Неверные входные данные",
                    error = ModelState.Values.SelectMany(e => e.Errors.Select(er => er.ErrorMessage))
                };
                return BadRequest(errorMsg);
            }
        }
    }
}
