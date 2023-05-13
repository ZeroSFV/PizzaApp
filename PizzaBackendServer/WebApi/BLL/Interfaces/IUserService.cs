using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Models;

namespace BLL.Interfaces
{
    public interface IUserService
    {
        UserInfoModel GetUserInfo(int userId);
        List<UserInfoModel> GetAllUsers();
        void ApproveUser(int userId);
        void DeleteUser(int userId);
        List<UserInfoModel> GetAllUnapprovedUser();
        List<UserInfoModel> GetAllCouriers();
        List<UserInfoModel> GetAllWorkers();
        Task CreateUser(SignUpWorkerCourierModel signUpModel);
        UserModel GetUserById(int id);
        void UpdateUser(UserUpdateModel userUpdateModel);
        void UpdateWorkerCourier(WorkerCourierUpdateModel workerCourierUpdateModel);
    }
}
