using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.Interfaces;
using DAL.Data;
using BLL.Models;
using System.Collections.ObjectModel;
using System.IdentityModel.Tokens.Jwt;
using MimeKit;
using MailKit.Net.Smtp;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace BLL.Services
{
    public class UserService : IUserService
    {
        IUnitOfWork dataBase;

        public UserService(IUnitOfWork repos)
        {
            dataBase = repos;
        }

        public UserInfoModel GetUserInfo(int userId)
        {
            var userModel = dataBase.UserRepository.GetAll()
                                                   .Select(i => new UserModel(i))
                                                   .Where(i => i.Id == userId)
                                                   .OrderBy(i => i.Name)
                                                   .FirstOrDefault();
            if (userModel != null)
            {
                UserInfoModel userInfoModel = new UserInfoModel(userModel);
                return userInfoModel;
            }
            else return null;
        }

        public UserModel GetUserById(int id)
        {
            var user = dataBase.UserRepository.Get(id);
            if (user != null)
            {
                return new UserModel(user);
            }
            else return null;
        }

        public List<UserInfoModel> GetAllUsers()
        {
            var userModels = dataBase.UserRepository.GetAll()
                                                    .Select(i => new UserModel(i))
                                                    .OrderBy(i => i.Name)
                                                    .ToList();
            if (userModels != null)
            {
                List<UserInfoModel> userInfo = new List<UserInfoModel>();
                foreach (UserModel u in userModels)
                {
                    userInfo.Add(new UserInfoModel(u));
                }
                return userInfo;
            }
            else return null;
        }

        public List<UserInfoModel> GetAllUnapprovedUser()
        {
            var userModels = dataBase.UserRepository.GetAll()
                                                    .Select(i => new UserModel(i))
                                                    .Where(i => i.IsApproved == false)
                                                    .OrderBy(i => i.Name)
                                                    .ToList();
            if (userModels != null)
            {
                List<UserInfoModel> userInfo = new List<UserInfoModel>();
                foreach (UserModel u in userModels)
                {
                    userInfo.Add(new UserInfoModel(u));
                }
                return userInfo;
            }
            else return null;
        }

        public List<UserInfoModel> GetAllWorkers()
        {
            var userModels = dataBase.UserRepository.GetAll()
                                                    .Select(i => new UserModel(i))
                                                    .Where(i => i.Role == "worker")
                                                    .OrderBy(i => i.Name)
                                                    .ToList();
            if (userModels != null)
            {
                List<UserInfoModel> userInfo = new List<UserInfoModel>();
                foreach (UserModel u in userModels)
                {
                    userInfo.Add(new UserInfoModel(u));
                }
                return userInfo;
            }
            else return null;
        }

        public List<UserInfoModel> GetAllCouriers()
        {
            var userModels = dataBase.UserRepository.GetAll()
                                                    .Select(i => new UserModel(i))
                                                    .Where(i => i.Role == "courier")
                                                    .OrderBy (i => i.Name)
                                                    .ToList();
            if (userModels != null)
            {
                List<UserInfoModel> userInfo = new List<UserInfoModel>();
                foreach (UserModel u in userModels)
                {
                    userInfo.Add(new UserInfoModel(u));
                }
                return userInfo;
            }
            else return null;
        }

        public async Task CreateUser(SignUpWorkerCourierModel signUpModel)
        {
            User user = new User
            {
                Role = signUpModel.Role,
                Name = signUpModel.Name,
                Passport = signUpModel.Passport,
                Password = HashPasswordService.HashUserPassword(signUpModel.Password),
                Email = signUpModel.Email,
                IsApproved = 1,
                Bonuses = null,
                Phone = signUpModel.Phone,
                RefreshToken = null
            };
            dataBase.UserRepository.Create(user);
            Save();
            string jsonFromFile;
            using (var reader = new StreamReader("./Options/SenderCredentials.json"))
            {
                jsonFromFile = reader.ReadToEnd();
            }
            var credentialsFromJson = JsonConvert.DeserializeObject<CredentialsModel>(jsonFromFile);

            var emailMessage = new MimeMessage();
            emailMessage.From.Add(new MailboxAddress("Пиццерия Pizzer", credentialsFromJson.Email));
            emailMessage.To.Add(new MailboxAddress("", signUpModel.Email));
            emailMessage.Subject = "Ваш аккаунт в пиццерии Pizzer создан";
            if (signUpModel.Role == "worker")
            {
                emailMessage.Body = new TextPart(MimeKit.Text.TextFormat.Html)
                {
                    Text = "Ваш аккант работника c почтой " + signUpModel.Email + " создан. Пароль к аккаунту - " + signUpModel.Password 
                };
            }
            if (signUpModel.Role == "courier")
            {
                emailMessage.Body = new TextPart(MimeKit.Text.TextFormat.Html)
                {
                    Text = "Ваш аккант курьера c почтой " + signUpModel.Email + " создан. Пароль к аккаунту - " + signUpModel.Password
                };
            }
            using (var client = new SmtpClient())
            {
                if (credentialsFromJson.Email.Contains("@yandex.ru"))
                {
                    await client.ConnectAsync("smtp.yandex.ru", 25, false);
                }
                else if (credentialsFromJson.Email.Contains("@gmail.com"))
                {
                    await client.ConnectAsync("smtp.gmail.com", 587, false);
                }
                else if (credentialsFromJson.Email.Contains("@mail.ru"))
                {
                    await client.ConnectAsync("smtp.mail.ru", 25, false);
                }
                await client.AuthenticateAsync(credentialsFromJson.Email, credentialsFromJson.Password);
                await client.SendAsync(emailMessage);

                await client.DisconnectAsync(true);
            }
        }

        public void ApproveUser(int userId)
        {
            var user = dataBase.UserRepository.GetAll()
                                              .Where(i => i.Id.Equals(userId))
                                              .FirstOrDefault();
            if (user != null)
            {
                user.IsApproved = 1;
                dataBase.UserRepository.Update(user);
                Save();
            }
        }

        public void DeleteUser(int userId)
        {
            var user = dataBase.UserRepository.GetAll()
                                              .Where(i => i.Id == userId)
                                              .FirstOrDefault();
            if (user != null)
            {
                if (user.Role == "user")
                {
                    var baskets = dataBase.BasketRepository.GetAll()
                                                           .Where(i => i.UserId == user.Id)
                                                           .ToList();
                    foreach (var b in baskets)
                    {
                        dataBase.BasketRepository.Delete(b.Id);
                        Save();
                    }
                    var orders = dataBase.OrderRepository.GetAll()
                                                         .Where(i => i.ClientId == user.Id)
                                                         .ToList();
                    foreach (var o in orders)
                    {
                        var orderStrings = dataBase.OrderStringRepository.GetAll()
                                                                         .Where(i => i.OrderId == o.Id)
                                                                         .ToList();
                        foreach (var s in orderStrings)
                        {
                            dataBase.OrderStringRepository.Delete(s.Id);
                        }
                        dataBase.OrderRepository.Delete(o.Id);
                        Save();
                    }
                }
                else if (user.Role == "worker")
                {
                    var orders = dataBase.OrderRepository.GetAll()
                                                         .Where(i => i.WorkerId == user.Id)
                                                         .ToList();
                    foreach (var o in orders)
                    {
                        o.WorkerId = null;
                        dataBase.OrderRepository.Update(o);
                        Save();
                    }
                }
                else if (user.Role == "courier")
                {
                    var orders = dataBase.OrderRepository.GetAll()
                                                         .Where(i => i.CourierId == user.Id)
                                                         .ToList();
                    foreach (var o in orders)
                    {
                        o.CourierId = null;
                        dataBase.OrderRepository.Update(o);
                        Save();
                    }
                }
                dataBase.UserRepository.Delete(user.Id);
                Save();
            }
        }

        public bool Save()
        {
            dataBase.Save();
            return true;
        }
    }
}
