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

namespace BLL.Services
{
    public class UserService : IUserService
    {
        IUnitOfWork dataBase;

        public UserService(IUnitOfWork repos)
        {
            dataBase = repos;
        }
    }
}
