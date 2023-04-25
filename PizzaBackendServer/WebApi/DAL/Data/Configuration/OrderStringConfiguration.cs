using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data.Configuration
{
    public class OrderStringConfiguration : IEntityTypeConfiguration<OrderString>
    {
        public void Configure(EntityTypeBuilder<OrderString> builder)
        {
            builder.ToTable("orderString");

            builder.Property(e => e.Id).ValueGeneratedOnAdd();

            builder.HasIndex(e => e.OrderId, "order_idx");

            builder.HasIndex(e => e.PizzaId, "pizza_idx");

            builder.HasOne(d => d.Order)
                .WithMany(p => p.OrderStrings)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("orderId");

            builder.HasOne(d => d.Pizza)
                .WithMany(p => p.OrderStrings)
                .HasForeignKey(d => d.PizzaId)
                .HasConstraintName("pizzaId");

            builder.HasData(
                new OrderString
                {
                    Id = 1,
                    Count = 1,
                    PizzaId = 1,
                    OrderId = 1,
                },
                new OrderString
                {
                    Id = 2,
                    Count = 1,
                    PizzaId = 1,
                    OrderId = 2,
                },
                new OrderString
                {
                    Id = 3,
                    Count = 1,
                    PizzaId = 1,
                    OrderId = 3,
                }
                );
        }
    }
}
