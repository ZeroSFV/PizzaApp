﻿// <auto-generated />
using System;
using DAL.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace DAL.Migrations
{
    [DbContext(typeof(PizzaContext))]
    partial class PizzaContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .UseCollation("utf8mb4_0900_ai_ci")
                .HasAnnotation("ProductVersion", "6.0.6")
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            MySqlModelBuilderExtensions.HasCharSet(modelBuilder, "utf8mb4");

            modelBuilder.Entity("DAL.Data.Basket", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<int>("Amount")
                        .HasColumnType("int");

                    b.Property<int>("PizzaId")
                        .HasColumnType("int");

                    b.Property<decimal>("Price")
                        .HasPrecision(8, 2)
                        .HasColumnType("decimal(8,2)");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "PizzaId" }, "pizza_idx");

                    b.HasIndex(new[] { "UserId" }, "user_idx");

                    b.ToTable("basket", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Amount = 1,
                            PizzaId = 1,
                            Price = 0m,
                            UserId = 1
                        });
                });

            modelBuilder.Entity("DAL.Data.Order", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Address")
                        .IsRequired()
                        .HasMaxLength(70)
                        .HasColumnType("varchar(70)");

                    b.Property<decimal?>("Change")
                        .HasPrecision(8, 2)
                        .HasColumnType("decimal(8,2)");

                    b.Property<int>("ClientId")
                        .HasColumnType("int");

                    b.Property<string>("ClientName")
                        .IsRequired()
                        .HasMaxLength(70)
                        .HasColumnType("varchar(70)");

                    b.Property<string>("Comment")
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.Property<int?>("CourierId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreationTime")
                        .HasColumnType("datetime");

                    b.Property<DateTime?>("FinishedTime")
                        .HasColumnType("datetime");

                    b.Property<int>("GivenBonuses")
                        .HasColumnType("int");

                    b.Property<string>("PayingType")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("varchar(20)");

                    b.Property<string>("PhoneNumber")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar(50)");

                    b.Property<DateTime?>("PredictedTime")
                        .HasColumnType("datetime");

                    b.Property<decimal>("Price")
                        .HasPrecision(8, 2)
                        .HasColumnType("decimal(8,2)");

                    b.Property<int>("StatusId")
                        .HasColumnType("int");

                    b.Property<int?>("UsedBonuses")
                        .HasColumnType("int");

                    b.Property<int?>("WorkerId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "ClientId" }, "client_idx");

                    b.HasIndex(new[] { "CourierId" }, "courier_idx");

                    b.HasIndex(new[] { "StatusId" }, "status_idx");

                    b.HasIndex(new[] { "WorkerId" }, "worker_idx");

                    b.ToTable("order", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Address = "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1",
                            Change = 370m,
                            ClientId = 1,
                            ClientName = "Михаил",
                            CourierId = 4,
                            CreationTime = new DateTime(2022, 4, 24, 18, 0, 0, 0, DateTimeKind.Unspecified),
                            FinishedTime = new DateTime(2022, 4, 24, 18, 30, 0, 0, DateTimeKind.Unspecified),
                            GivenBonuses = 63,
                            PayingType = "Наличными",
                            PhoneNumber = "+79106991174",
                            PredictedTime = new DateTime(2022, 4, 24, 19, 0, 0, 0, DateTimeKind.Unspecified),
                            Price = 630m,
                            StatusId = 5,
                            WorkerId = 3
                        },
                        new
                        {
                            Id = 2,
                            Address = "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1",
                            ClientId = 1,
                            ClientName = "Михаил",
                            CreationTime = new DateTime(2022, 4, 24, 17, 0, 0, 0, DateTimeKind.Unspecified),
                            GivenBonuses = 63,
                            PayingType = "Картой",
                            PhoneNumber = "+79106991174",
                            PredictedTime = new DateTime(2022, 4, 24, 20, 0, 0, 0, DateTimeKind.Unspecified),
                            Price = 630m,
                            StatusId = 1
                        },
                        new
                        {
                            Id = 3,
                            Address = "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1",
                            ClientId = 1,
                            ClientName = "Виктор",
                            CreationTime = new DateTime(2022, 4, 24, 14, 0, 0, 0, DateTimeKind.Unspecified),
                            GivenBonuses = 63,
                            PayingType = "Картой",
                            PhoneNumber = "+79106991174",
                            PredictedTime = new DateTime(2022, 4, 24, 15, 0, 0, 0, DateTimeKind.Unspecified),
                            Price = 630m,
                            StatusId = 6,
                            UsedBonuses = 63
                        },
                        new
                        {
                            Id = 4,
                            Address = "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1",
                            Change = 70m,
                            ClientId = 1,
                            ClientName = "Михаил",
                            Comment = "Пиццы пожалуйста без огурцов",
                            CreationTime = new DateTime(2022, 4, 24, 18, 0, 0, 0, DateTimeKind.Unspecified),
                            GivenBonuses = 63,
                            PayingType = "Наличными",
                            PhoneNumber = "+79106991174",
                            PredictedTime = new DateTime(2022, 4, 24, 19, 0, 0, 0, DateTimeKind.Unspecified),
                            Price = 630m,
                            StatusId = 3,
                            WorkerId = 3
                        });
                });

            modelBuilder.Entity("DAL.Data.OrderString", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<int>("Count")
                        .HasColumnType("int");

                    b.Property<int>("OrderId")
                        .HasColumnType("int");

                    b.Property<int>("PizzaId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "OrderId" }, "order_idx");

                    b.HasIndex(new[] { "PizzaId" }, "pizza_idx")
                        .HasDatabaseName("pizza_idx1");

                    b.ToTable("orderString", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Count = 1,
                            OrderId = 1,
                            PizzaId = 1
                        },
                        new
                        {
                            Id = 2,
                            Count = 1,
                            OrderId = 2,
                            PizzaId = 1
                        },
                        new
                        {
                            Id = 3,
                            Count = 1,
                            OrderId = 3,
                            PizzaId = 1
                        });
                });

            modelBuilder.Entity("DAL.Data.Pizza", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Consistance")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar(50)");

                    b.Property<string>("Photo")
                        .HasMaxLength(256)
                        .HasColumnType("varchar(256)");

                    b.Property<sbyte>("Prescence")
                        .HasColumnType("tinyint");

                    b.Property<decimal>("Price")
                        .HasPrecision(8, 2)
                        .HasColumnType("decimal(8,2)");

                    b.Property<int>("SizeId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "SizeId" }, "size_idx");

                    b.ToTable("pizza", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Consistance = "Тесто дрожжевое, сыр Моцарелла, колбаса пепперони (острая), соус томатный, сушеный базилик.",
                            Description = "Мясная",
                            Name = "Пепперони",
                            Photo = "assets/Pepperoni.png",
                            Prescence = (sbyte)1,
                            Price = 630m,
                            SizeId = 1
                        },
                        new
                        {
                            Id = 2,
                            Consistance = "Тесто дрожжевое, сыр Моцарелла, колбаса пепперони (острая), соус томатный, сушеный базилик.",
                            Description = "Мясная",
                            Name = "Пепперони",
                            Photo = "assets/Pepperoni.png",
                            Prescence = (sbyte)1,
                            Price = 562m,
                            SizeId = 2
                        },
                        new
                        {
                            Id = 3,
                            Consistance = "Тесто дрожжевое, сыр Моцарелла, колбаски охотничьи, соус томатный, бастурма, колбаса пепперони (острая), масло чесночное, перец халапеньо, сушеный базилик.",
                            Description = "Острая Мясная",
                            Name = "Баварская",
                            Photo = "assets/Bavarian.png",
                            Prescence = (sbyte)1,
                            Price = 612m,
                            SizeId = 1
                        },
                        new
                        {
                            Id = 4,
                            Consistance = "Тесто дрожжевое, сыр Моцарелла, колбаски охотничьи, соус томатный, бастурма, колбаса пепперони (острая), масло чесночное, перец халапеньо, сушеный базилик.",
                            Description = "Острая Мясная",
                            Name = "Баварская",
                            Photo = "assets/Bavarian.png",
                            Prescence = (sbyte)1,
                            Price = 562m,
                            SizeId = 2
                        },
                        new
                        {
                            Id = 5,
                            Consistance = "Тесто дрожжевое, сыр Моцарелла, куриное филе, соус цезарь, помидоры свежие, сыр пармезан, шампиньоны свежие, сливки, микс салат, сушеный базилик.",
                            Description = "Грибная",
                            Name = "Жюльен",
                            Photo = "assets/Zhulien.png",
                            Prescence = (sbyte)1,
                            Price = 590m,
                            SizeId = 1
                        },
                        new
                        {
                            Id = 6,
                            Consistance = "Тесто дрожжевое, сыр Моцарелла, куриное филе, соус цезарь, помидоры свежие, сыр пармезан, шампиньоны свежие, сливки, микс салат, сушеный базилик.",
                            Description = "Грибная",
                            Name = "Жюльен",
                            Photo = "assets/Zhulien.png",
                            Prescence = (sbyte)1,
                            Price = 445m,
                            SizeId = 2
                        },
                        new
                        {
                            Id = 7,
                            Consistance = "Тесто дрожжевое, сыр Моцарелла, семга, соус фирменный (лечо, майонез), креветки, лук репчатый красный, сушеный базилик.",
                            Description = "Рыбная",
                            Name = "Золотая рыбка",
                            Photo = "assets/GoldenFish.png",
                            Prescence = (sbyte)1,
                            Price = 840m,
                            SizeId = 1
                        },
                        new
                        {
                            Id = 8,
                            Consistance = "Тесто дрожжевое, сыр Моцарелла, семга, соус фирменный (лечо, майонез), креветки, лук репчатый красный, сушеный базилик.",
                            Description = "Рыбная",
                            Name = "Золотая рыбка",
                            Photo = "assets/GoldenFish.png",
                            Prescence = (sbyte)1,
                            Price = 670m,
                            SizeId = 2
                        },
                        new
                        {
                            Id = 9,
                            Consistance = "Тесто дрожжевое, сыр Моцарелла, ветчина, соус \"Гриль-Бургер\", куриное филе, перец сладкий болгарский, соус сладкий чили, колбаса пепперони (острая), лук репчатый красный, зелень рукколы.",
                            Description = "Острая мясная",
                            Name = "Пиццбургер",
                            Photo = "assets/PizzaBurger.png",
                            Prescence = (sbyte)1,
                            Price = 730m,
                            SizeId = 1
                        },
                        new
                        {
                            Id = 10,
                            Consistance = "Тесто дрожжевое, сыр Моцарелла, ветчина, соус \"Гриль-Бургер\", куриное филе, перец сладкий болгарский, соус сладкий чили, колбаса пепперони (острая), лук репчатый красный, зелень рукколы.",
                            Description = "Острая мясная",
                            Name = "Пиццбургер",
                            Photo = "assets/PizzaBurger.png",
                            Prescence = (sbyte)1,
                            Price = 540m,
                            SizeId = 2
                        });
                });

            modelBuilder.Entity("DAL.Data.Size", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar(50)");

                    b.HasKey("Id");

                    b.ToTable("size", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Name = "Большая"
                        },
                        new
                        {
                            Id = 2,
                            Name = "Средняя"
                        });
                });

            modelBuilder.Entity("DAL.Data.Status", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar(50)");

                    b.HasKey("Id");

                    b.ToTable("status", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Name = "Оформлен"
                        },
                        new
                        {
                            Id = 2,
                            Name = "На кухне"
                        },
                        new
                        {
                            Id = 3,
                            Name = "Комплектуется"
                        },
                        new
                        {
                            Id = 4,
                            Name = "Доставляется"
                        },
                        new
                        {
                            Id = 5,
                            Name = "Доставлен"
                        },
                        new
                        {
                            Id = 6,
                            Name = "Отменён"
                        });
                });

            modelBuilder.Entity("DAL.Data.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("ApprovalCode")
                        .IsRequired()
                        .HasMaxLength(6)
                        .HasColumnType("varchar(6)");

                    b.Property<int?>("Bonuses")
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar(50)");

                    b.Property<sbyte>("IsApproved")
                        .HasColumnType("tinyint");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(70)
                        .HasColumnType("varchar(70)");

                    b.Property<string>("Passport")
                        .HasMaxLength(50)
                        .HasColumnType("varchar(50)");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasMaxLength(200)
                        .HasColumnType("varchar(200)");

                    b.Property<string>("Phone")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar(50)");

                    b.Property<string>("RefreshToken")
                        .HasMaxLength(200)
                        .HasColumnType("varchar(200)");

                    b.Property<string>("Role")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar(50)");

                    b.HasKey("Id");

                    b.ToTable("user", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            ApprovalCode = "123321",
                            Bonuses = 0,
                            Email = "reksmbd@gmail.com",
                            IsApproved = (sbyte)1,
                            Name = "Михаил Баусов Дмитриевич",
                            Password = "1U+u9QwJ8SdXuiRip3b83S7jiu06Z0PxlaPHFOJZJ+Q=:tiUz98Ow0IbpP7gWSLBCcA==",
                            Phone = "+79106991174",
                            Role = "user"
                        },
                        new
                        {
                            Id = 2,
                            ApprovalCode = "123321",
                            Email = "admin@gmail.com",
                            IsApproved = (sbyte)1,
                            Name = "Администратор",
                            Passport = "2415 771077",
                            Password = "8eqn6A6N11WY0k4j8PLlVfcmDvnUQZJOvTtxdBYtINA=:5tZTJitFXi/473n+fWFzog==",
                            Phone = "+79106151273",
                            Role = "admin"
                        },
                        new
                        {
                            Id = 3,
                            ApprovalCode = "123321",
                            Email = "worker@gmail.com",
                            IsApproved = (sbyte)1,
                            Name = "Работник",
                            Passport = "2416 772076",
                            Password = "ucPtmgnShnsbFBQVZg7kNukEDDluMTr2/fYAq3odDF8=:amw/M3NvUh1kzCQkIJnVIg==",
                            Phone = "+79156251375",
                            Role = "worker"
                        },
                        new
                        {
                            Id = 4,
                            ApprovalCode = "123321",
                            Email = "courier@gmail.com",
                            IsApproved = (sbyte)1,
                            Name = "Курьер",
                            Passport = "2316 771071",
                            Password = "ucPtmgnShnsbFBQVZg7kNukEDDluMTr2/fYAq3odDF8=:amw/M3NvUh1kzCQkIJnVIg==",
                            Phone = "+79176221355",
                            Role = "courier"
                        });
                });

            modelBuilder.Entity("DAL.Data.Basket", b =>
                {
                    b.HasOne("DAL.Data.Pizza", "Pizza")
                        .WithMany("Baskets")
                        .HasForeignKey("PizzaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired()
                        .HasConstraintName("pizzaIdx");

                    b.HasOne("DAL.Data.User", "User")
                        .WithMany("Baskets")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired()
                        .HasConstraintName("userId");

                    b.Navigation("Pizza");

                    b.Navigation("User");
                });

            modelBuilder.Entity("DAL.Data.Order", b =>
                {
                    b.HasOne("DAL.Data.User", "Client")
                        .WithMany("OrdersClient")
                        .HasForeignKey("ClientId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired()
                        .HasConstraintName("clientId");

                    b.HasOne("DAL.Data.User", "Courier")
                        .WithMany("OrdersCourier")
                        .HasForeignKey("CourierId")
                        .HasConstraintName("courierId");

                    b.HasOne("DAL.Data.Status", "Status")
                        .WithMany("Orders")
                        .HasForeignKey("StatusId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired()
                        .HasConstraintName("statusId");

                    b.HasOne("DAL.Data.User", "Worker")
                        .WithMany("OrdersWorker")
                        .HasForeignKey("WorkerId")
                        .HasConstraintName("workerId");

                    b.Navigation("Client");

                    b.Navigation("Courier");

                    b.Navigation("Status");

                    b.Navigation("Worker");
                });

            modelBuilder.Entity("DAL.Data.OrderString", b =>
                {
                    b.HasOne("DAL.Data.Order", "Order")
                        .WithMany("OrderStrings")
                        .HasForeignKey("OrderId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired()
                        .HasConstraintName("orderId");

                    b.HasOne("DAL.Data.Pizza", "Pizza")
                        .WithMany("OrderStrings")
                        .HasForeignKey("PizzaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired()
                        .HasConstraintName("pizzaId");

                    b.Navigation("Order");

                    b.Navigation("Pizza");
                });

            modelBuilder.Entity("DAL.Data.Pizza", b =>
                {
                    b.HasOne("DAL.Data.Size", "Size")
                        .WithMany("Pizzas")
                        .HasForeignKey("SizeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired()
                        .HasConstraintName("userFK");

                    b.Navigation("Size");
                });

            modelBuilder.Entity("DAL.Data.Order", b =>
                {
                    b.Navigation("OrderStrings");
                });

            modelBuilder.Entity("DAL.Data.Pizza", b =>
                {
                    b.Navigation("Baskets");

                    b.Navigation("OrderStrings");
                });

            modelBuilder.Entity("DAL.Data.Size", b =>
                {
                    b.Navigation("Pizzas");
                });

            modelBuilder.Entity("DAL.Data.Status", b =>
                {
                    b.Navigation("Orders");
                });

            modelBuilder.Entity("DAL.Data.User", b =>
                {
                    b.Navigation("Baskets");

                    b.Navigation("OrdersClient");

                    b.Navigation("OrdersCourier");

                    b.Navigation("OrdersWorker");
                });
#pragma warning restore 612, 618
        }
    }
}
