using DAL.Data.Configuration;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data
{
    public partial class PizzaContext : DbContext
    {
        public PizzaContext() { }

        public PizzaContext(DbContextOptions<PizzaContext> options) : base(options) { }

        public virtual DbSet<Basket> Baskets { get; set; }
        public virtual DbSet<Pizza> Pizzas { get; set; } = null!;
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderString> OrdersString { get; set; }
        public virtual DbSet<Size> Sizes { get; set; } = null!;
        public virtual DbSet<Status> Statuses { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySql("server=localhost;user=root;password=XDniggaXD334_fat_A;database=pizzer;",
                Microsoft.EntityFrameworkCore.ServerVersion.Parse("8.0.29-mysql"),
                options => options.EnableRetryOnFailure(3));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.UseCollation("utf8mb4_0900_ai_ci")
                .HasCharSet("utf8mb4");

            modelBuilder.ApplyConfiguration(new BasketConfiguration());
            modelBuilder.ApplyConfiguration(new OrderConfiguration());
            modelBuilder.ApplyConfiguration(new UserConfiguration());
            modelBuilder.ApplyConfiguration(new OrderStringConfiguration());
            modelBuilder.ApplyConfiguration(new PizzaConfiguration());
            modelBuilder.ApplyConfiguration(new SizeConfiguration());
            modelBuilder.ApplyConfiguration(new StatusConfiguration());

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
