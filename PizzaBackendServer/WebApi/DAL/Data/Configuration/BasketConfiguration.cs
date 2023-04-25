using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data.Configuration
{
    public class BasketConfiguration : IEntityTypeConfiguration<Basket>
    {
        public void Configure(EntityTypeBuilder<Basket> builder)
        {
            builder.ToTable("basket");

            builder.Property(e => e.Id).ValueGeneratedOnAdd();

            builder.HasIndex(e => e.UserId, "user_idx");

            builder.HasIndex(e => e.PizzaId, "pizza_idx");

            builder.Property(e => e.Price).HasPrecision(8, 2);

            builder.HasOne(d => d.Pizza)
                .WithMany(p => p.Baskets)
                .HasForeignKey(d => d.PizzaId)
                .HasConstraintName("pizzaIdx");

            builder.HasOne(d => d.User)
                .WithMany(p => p.Baskets)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("userId");
        }
    }
}
