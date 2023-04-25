using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data.Configuration
{
    public class StatusConfiguration : IEntityTypeConfiguration<Status>
    {
        public void Configure(EntityTypeBuilder<Status> builder)
        {
            builder.ToTable("status");
            
            builder.Property(e => e.Id).ValueGeneratedOnAdd();

            builder.Property(e => e.Name).HasMaxLength(50);

            builder.HasData(
                new Status
                {
                    Id = 1,
                    Name = "Оформлен"
                },
                new Status
                {
                    Id = 2,
                    Name = "На кухне"
                },
                new Status
                {
                    Id = 3,
                    Name = "Комплектуется"
                },
                new Status
                {
                    Id = 4,
                    Name = "Доставляется"
                },
                new Status
                {
                    Id = 5,
                    Name = "Доставлен"
                },
                new Status
                {
                    Id = 6,
                    Name = "Отменён"
                }
                ); 
        }
    }
}
