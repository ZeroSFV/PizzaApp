using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data.Configuration
{
    public class OrderConfiguration : IEntityTypeConfiguration<Order>
    {
        public void Configure(EntityTypeBuilder<Order> builder)
        {
            builder.ToTable("order");

            builder.Property(e => e.Id).ValueGeneratedOnAdd();

            builder.Property(e => e.CreationTime).HasColumnType("datetime");

            builder.Property(e => e.FinishedTime).HasColumnType("datetime");

            builder.Property(e => e.Address).HasMaxLength(70);

            builder.Property(e => e.PhoneNumber).HasMaxLength(50);

            builder.Property(e => e.Price).HasPrecision(8, 2);
            
            builder.Property(e => e.Change).HasPrecision(8, 2);

            builder.Property(e => e.ClientName).HasMaxLength(70);

            builder.Property(e => e.PayingType).HasMaxLength(20);

            builder.HasIndex(e => e.ClientId, "client_idx");

            builder.HasIndex(e => e.WorkerId, "worker_idx");

            builder.HasIndex(e => e.CourierId, "courier_idx");

            builder.HasIndex(e => e.StatusId, "status_idx");

            builder.HasOne(d => d.Client)
                .WithMany(p => p.OrdersClient)
                .HasForeignKey(d => d.ClientId)
                .HasConstraintName("clientId");

            builder.HasOne(d => d.Worker)
                .WithMany(p => p.OrdersWorker)
                .HasForeignKey(d => d.WorkerId)
                .HasConstraintName("workerId");

            builder.HasOne(d => d.Courier)
                .WithMany(p => p.OrdersCourier)
                .HasForeignKey(d => d.CourierId)
                .HasConstraintName("courierId");

            builder.HasOne(d => d.Status)
                .WithMany(p => p.Orders)
                .HasForeignKey(d => d.StatusId)
                .HasConstraintName("statusId");

            builder.HasData(
                new Order
                {
                    Id = 1,
                    CreationTime = new DateTime(2022, 04, 24, 18, 0, 0),
                    FinishedTime = new DateTime(2022, 04, 24, 18, 30, 0),
                    Price = 630,
                    Address = "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1",
                    PhoneNumber = "+79106991174",
                    ClientName = "Михаил",
                    PayingType = "Наличными",
                    Change = 370,
                    StatusId = 5,
                    ClientId = 1,
                    WorkerId = 3,
                    CourierId = 4,
                },
                new Order
                {
                    Id = 2,
                    CreationTime = new DateTime(2022, 04, 24, 17, 0, 0),
                    Price = 630,
                    Address = "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1",
                    PhoneNumber = "+79106991174",
                    ClientName = "Михаил",
                    PayingType = "Картой",
                    StatusId = 1,
                    ClientId = 1,
                },
                new Order
                {
                    Id = 3,
                    CreationTime = new DateTime(2022, 04, 24, 14, 0, 0),
                    Price = 630,
                    Address = "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1",
                    PhoneNumber = "+79106991174",
                    ClientName = "Виктор",
                    PayingType = "Картой",
                    StatusId = 6,
                    ClientId = 1,

                },
                new Order
                {
                    Id = 4,
                    CreationTime = new DateTime(2022, 04, 24, 18, 0, 0),
                    Price = 630,
                    Address = "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1",
                    PhoneNumber = "+79106991174",
                    ClientName = "Михаил",
                    PayingType = "Наличными",
                    Change = 70,
                    StatusId = 3,
                    ClientId = 1,
                    WorkerId = 3
                }
                );
        }

    }
}
