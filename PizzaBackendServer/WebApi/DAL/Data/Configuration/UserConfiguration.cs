using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data.Configuration
{
    public class UserConfiguration : IEntityTypeConfiguration<User>
    {
        public void Configure(EntityTypeBuilder<User> builder)
        {
            builder.ToTable("user");
            
            builder.Property(e => e.Id).ValueGeneratedOnAdd();
            
            builder.Property(e => e.Email).HasMaxLength(50);

            builder.Property(e => e.Name).HasMaxLength(70);

            builder.Property(e => e.ApprovalCode).HasMaxLength(6);

            builder.Property(e => e.Password).HasMaxLength(200);

            builder.Property(e => e.Role).HasMaxLength(50);

            builder.Property(e => e.RefreshToken).HasMaxLength(200);

            builder.Property(e => e.Passport).HasMaxLength(50);

            builder.Property(e => e.Phone).HasMaxLength(50);

            builder.HasData(
                new User
                {
                    Id = 1,
                    Email = "reksmbd@gmail.com",
                    IsApproved = (sbyte)1,
                    Name = "Михаил Баусов Дмитриевич",
                    Password = "1U+u9QwJ8SdXuiRip3b83S7jiu06Z0PxlaPHFOJZJ+Q=:tiUz98Ow0IbpP7gWSLBCcA==",
                    Role = "user",
                    Bonuses = 0,
                    Phone = "+79106991174", 
                    ApprovalCode = "123321"
                },
                new User
                {
                    Id = 2,
                    Email = "admin@gmail.com",
                    IsApproved = (sbyte)1,
                    Name = "Администратор",
                    Password = "8eqn6A6N11WY0k4j8PLlVfcmDvnUQZJOvTtxdBYtINA=:5tZTJitFXi/473n+fWFzog==",
                    Role = "admin",
                    Phone = "+79106151273",
                    Passport = "2415 771077",
                    ApprovalCode = "123321"
                },
                new User
                {
                    Id = 3,
                    Email = "worker@gmail.com",
                    IsApproved = (sbyte)1,
                    Name = "Работник",
                    Password = "ucPtmgnShnsbFBQVZg7kNukEDDluMTr2/fYAq3odDF8=:amw/M3NvUh1kzCQkIJnVIg==",
                    Role = "worker",
                    Phone = "+79156251375",
                    Passport = "2416 772076",
                    ApprovalCode = "123321"
                },
                new User
                {
                    Id = 4,
                    Email = "courier@gmail.com",
                    IsApproved = (sbyte)1,
                    Name = "Курьер",
                    Password = "ucPtmgnShnsbFBQVZg7kNukEDDluMTr2/fYAq3odDF8=:amw/M3NvUh1kzCQkIJnVIg==",
                    Role = "courier",
                    Phone = "+79176221355",
                    Passport = "2316 771071",
                    ApprovalCode = "123321"
                }
                );
        }
    }
}
