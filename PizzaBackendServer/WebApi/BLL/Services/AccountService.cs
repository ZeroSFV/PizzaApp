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
using Microsoft.Extensions.Logging;

namespace BLL.Services
{
    public class AccountService : IAccountService
    {
        IUnitOfWork dataBase;

        public AccountService(IUnitOfWork repos)
        {
            dataBase = repos;
        }

        public bool CheckUserByEmail(string email)
        {
            var user = dataBase.UserRepository.GetAll()
                                              .Select(i => new UserModel(i))
                                              .Where(i => i.Email == email)
                                              .FirstOrDefault();
            if (user == null)
                return false;
            else return true;
        }

        public async Task CreateUser(SignUpModel signUpModel)
        {
            User user = new User
            {
                Role = "user",
                Name = signUpModel.Name,
                Password = HashPasswordService.HashUserPassword(signUpModel.Password),
                Email = signUpModel.Email,
                IsApproved = 0,
                Bonuses = 0,
                Phone = signUpModel.Phone,
                RefreshToken = null
            };
            dataBase.UserRepository.Create(user);
            Save();
        }

        public UserModel GetUserByEmailAndPassword(string email, string password)
        {
            return dataBase.UserRepository.GetAll()
                                          .Select(i => new UserModel(i))
                                          .Where(i => i.Email == email)
                                          .Where(i => HashPasswordService.VerifyUserPassword(password, i.Password) == true)
                                          .FirstOrDefault();
        }

        public void UpdateUser(UserModel userModel)
        {
            var user = dataBase.UserRepository.Get(userModel.Id);
            if (user != null)
            {
                user.RefreshToken = userModel.RefreshToken;
                dataBase.UserRepository.Update(user);
                Save();
            }
        }

        public bool ChangePasswordOfUser(ChangePasswordModel changePasswordModel)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var jwt = tokenHandler.ReadJwtToken(changePasswordModel.token);
            int id = Int32.Parse(jwt.Claims.First(claim => claim.Type == JwtRegisteredClaimNames.Sub).Value);
            User user = dataBase.UserRepository.GetAll().Where(i => i.Id == id).FirstOrDefault();
            if (HashPasswordService.VerifyUserPassword(changePasswordModel.OldPassword, user.Password))
            {
                user.Password = HashPasswordService.HashUserPassword(changePasswordModel.NewPassword);
                dataBase.UserRepository.Update(user);
                Save();
                return true;
            }
            else return false;
        }

        public async Task ResetPasswordOfUser(string email)
        {
            var user = dataBase.UserRepository.GetAll()
                                              .Where(i => i.Email == email)
                                              .FirstOrDefault();
            if (user != null)
            {
                Random rd = new Random();
                int length = rd.Next(6, 30);

                const string chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < length; i++)
                {
                    int index = rd.Next(chars.Length);
                    sb.Append(chars[index]);
                }
                user.Password = HashPasswordService.HashUserPassword(sb.ToString());
                dataBase.UserRepository.Update(user);
                Save();

                string jsonFromFile;
                using (var reader = new StreamReader("./Options/SenderCredentials.json"))
                {
                    jsonFromFile = reader.ReadToEnd();
                }
                var credentialsFromJson = JsonConvert.DeserializeObject<CredentialsModel>(jsonFromFile);

                var emailMessage = new MimeMessage();
                emailMessage.From.Add(new MailboxAddress("Пиццерия Pizzer", credentialsFromJson.Email));
                emailMessage.To.Add(new MailboxAddress("", email));
                emailMessage.Subject = "Новый пароль";
                emailMessage.Body = new TextPart(MimeKit.Text.TextFormat.Html)
                {
                    Text = "Ваш пароль был сброшен! Ваш новый пароль - " + sb.ToString()
                };

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
        }

        public bool Save()
        {
            dataBase.Save();
            return true;
        }
    }
}
