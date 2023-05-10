using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DAL.Migrations
{
    public partial class migrations : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "size",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Name = table.Column<string>(type: "varchar(50)", maxLength: 50, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_size", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_0900_ai_ci");

            migrationBuilder.CreateTable(
                name: "status",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Name = table.Column<string>(type: "varchar(50)", maxLength: 50, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_status", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_0900_ai_ci");

            migrationBuilder.CreateTable(
                name: "user",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Email = table.Column<string>(type: "varchar(50)", maxLength: 50, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Password = table.Column<string>(type: "varchar(200)", maxLength: 200, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Name = table.Column<string>(type: "varchar(70)", maxLength: 70, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Phone = table.Column<string>(type: "varchar(50)", maxLength: 50, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Passport = table.Column<string>(type: "varchar(50)", maxLength: 50, nullable: true, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Bonuses = table.Column<int>(type: "int", nullable: true),
                    Role = table.Column<string>(type: "varchar(50)", maxLength: 50, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    IsApproved = table.Column<sbyte>(type: "tinyint", nullable: false),
                    RefreshToken = table.Column<string>(type: "varchar(200)", maxLength: 200, nullable: true, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_user", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_0900_ai_ci");

            migrationBuilder.CreateTable(
                name: "pizza",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Name = table.Column<string>(type: "varchar(50)", maxLength: 50, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Price = table.Column<decimal>(type: "decimal(8,2)", precision: 8, scale: 2, nullable: false),
                    Description = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Prescence = table.Column<sbyte>(type: "tinyint", nullable: false),
                    Consistance = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    SizeId = table.Column<int>(type: "int", nullable: false),
                    Photo = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: true, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_pizza", x => x.Id);
                    table.ForeignKey(
                        name: "userFK",
                        column: x => x.SizeId,
                        principalTable: "size",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_0900_ai_ci");

            migrationBuilder.CreateTable(
                name: "order",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    CreationTime = table.Column<DateTime>(type: "datetime", nullable: false),
                    PredictedTime = table.Column<DateTime>(type: "datetime", nullable: true),
                    FinishedTime = table.Column<DateTime>(type: "datetime", nullable: true),
                    Price = table.Column<decimal>(type: "decimal(8,2)", precision: 8, scale: 2, nullable: false),
                    Address = table.Column<string>(type: "varchar(70)", maxLength: 70, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    PhoneNumber = table.Column<string>(type: "varchar(50)", maxLength: 50, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ClientName = table.Column<string>(type: "varchar(70)", maxLength: 70, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    PayingType = table.Column<string>(type: "varchar(20)", maxLength: 20, nullable: false, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Change = table.Column<decimal>(type: "decimal(8,2)", precision: 8, scale: 2, nullable: true),
                    UsedBonuses = table.Column<int>(type: "int", nullable: true),
                    GivenBonuses = table.Column<int>(type: "int", nullable: false),
                    Comment = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: true, collation: "utf8mb4_0900_ai_ci")
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ClientId = table.Column<int>(type: "int", nullable: false),
                    WorkerId = table.Column<int>(type: "int", nullable: true),
                    CourierId = table.Column<int>(type: "int", nullable: true),
                    StatusId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_order", x => x.Id);
                    table.ForeignKey(
                        name: "clientId",
                        column: x => x.ClientId,
                        principalTable: "user",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "courierId",
                        column: x => x.CourierId,
                        principalTable: "user",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "statusId",
                        column: x => x.StatusId,
                        principalTable: "status",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "workerId",
                        column: x => x.WorkerId,
                        principalTable: "user",
                        principalColumn: "Id");
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_0900_ai_ci");

            migrationBuilder.CreateTable(
                name: "basket",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Amount = table.Column<int>(type: "int", nullable: false),
                    Price = table.Column<decimal>(type: "decimal(8,2)", precision: 8, scale: 2, nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    PizzaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_basket", x => x.Id);
                    table.ForeignKey(
                        name: "pizzaIdx",
                        column: x => x.PizzaId,
                        principalTable: "pizza",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "userId",
                        column: x => x.UserId,
                        principalTable: "user",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_0900_ai_ci");

            migrationBuilder.CreateTable(
                name: "orderString",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Count = table.Column<int>(type: "int", nullable: false),
                    PizzaId = table.Column<int>(type: "int", nullable: false),
                    OrderId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_orderString", x => x.Id);
                    table.ForeignKey(
                        name: "orderId",
                        column: x => x.OrderId,
                        principalTable: "order",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "pizzaId",
                        column: x => x.PizzaId,
                        principalTable: "pizza",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4")
                .Annotation("Relational:Collation", "utf8mb4_0900_ai_ci");

            migrationBuilder.InsertData(
                table: "size",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Большая" },
                    { 2, "Средняя" }
                });

            migrationBuilder.InsertData(
                table: "status",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Оформлен" },
                    { 2, "На кухне" },
                    { 3, "Комплектуется" },
                    { 4, "Доставляется" },
                    { 5, "Доставлен" },
                    { 6, "Отменён" }
                });

            migrationBuilder.InsertData(
                table: "user",
                columns: new[] { "Id", "Bonuses", "Email", "IsApproved", "Name", "Passport", "Password", "Phone", "RefreshToken", "Role" },
                values: new object[,]
                {
                    { 1, 0, "reksmbd@gmail.com", (sbyte)1, "Михаил Баусов Дмитриевич", null, "1U+u9QwJ8SdXuiRip3b83S7jiu06Z0PxlaPHFOJZJ+Q=:tiUz98Ow0IbpP7gWSLBCcA==", "+79106991174", null, "user" },
                    { 2, null, "admin@gmail.com", (sbyte)1, "Администратор", "2415 771077", "8eqn6A6N11WY0k4j8PLlVfcmDvnUQZJOvTtxdBYtINA=:5tZTJitFXi/473n+fWFzog==", "+79106151273", null, "admin" },
                    { 3, null, "worker@gmail.com", (sbyte)1, "Работник", "2416 772076", "ucPtmgnShnsbFBQVZg7kNukEDDluMTr2/fYAq3odDF8=:amw/M3NvUh1kzCQkIJnVIg==", "+79156251375", null, "worker" },
                    { 4, null, "courier@gmail.com", (sbyte)1, "Курьер", "2316 771071", "ucPtmgnShnsbFBQVZg7kNukEDDluMTr2/fYAq3odDF8=:amw/M3NvUh1kzCQkIJnVIg==", "+79176221355", null, "courier" }
                });

            migrationBuilder.InsertData(
                table: "order",
                columns: new[] { "Id", "Address", "Change", "ClientId", "ClientName", "Comment", "CourierId", "CreationTime", "FinishedTime", "GivenBonuses", "PayingType", "PhoneNumber", "PredictedTime", "Price", "StatusId", "UsedBonuses", "WorkerId" },
                values: new object[,]
                {
                    { 1, "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1", 370m, 1, "Михаил", null, 4, new DateTime(2022, 4, 24, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2022, 4, 24, 18, 30, 0, 0, DateTimeKind.Unspecified), 63, "Наличными", "+79106991174", new DateTime(2022, 4, 24, 19, 0, 0, 0, DateTimeKind.Unspecified), 630m, 5, null, 3 },
                    { 2, "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1", null, 1, "Михаил", null, null, new DateTime(2022, 4, 24, 17, 0, 0, 0, DateTimeKind.Unspecified), null, 63, "Картой", "+79106991174", new DateTime(2022, 4, 24, 20, 0, 0, 0, DateTimeKind.Unspecified), 630m, 1, null, null },
                    { 3, "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1", null, 1, "Виктор", null, null, new DateTime(2022, 4, 24, 14, 0, 0, 0, DateTimeKind.Unspecified), null, 63, "Картой", "+79106991174", new DateTime(2022, 4, 24, 15, 0, 0, 0, DateTimeKind.Unspecified), 630m, 6, 63, null },
                    { 4, "Ул. Курьяновская, д.25, кв 20, этаж 5, подъезд 1", 70m, 1, "Михаил", "Пиццы пожалуйста без огурцов", null, new DateTime(2022, 4, 24, 18, 0, 0, 0, DateTimeKind.Unspecified), null, 63, "Наличными", "+79106991174", new DateTime(2022, 4, 24, 19, 0, 0, 0, DateTimeKind.Unspecified), 630m, 3, null, 3 }
                });

            migrationBuilder.InsertData(
                table: "pizza",
                columns: new[] { "Id", "Consistance", "Description", "Name", "Photo", "Prescence", "Price", "SizeId" },
                values: new object[,]
                {
                    { 1, "Тесто дрожжевое, сыр Моцарелла, колбаса пепперони (острая), соус томатный, сушеный базилик.", "Мясная", "Пепперони", "assets/Pepperoni.png", (sbyte)1, 630m, 1 },
                    { 2, "Тесто дрожжевое, сыр Моцарелла, колбаса пепперони (острая), соус томатный, сушеный базилик.", "Мясная", "Пепперони", "assets/Pepperoni.png", (sbyte)1, 562m, 2 },
                    { 3, "Тесто дрожжевое, сыр Моцарелла, колбаски охотничьи, соус томатный, бастурма, колбаса пепперони (острая), масло чесночное, перец халапеньо, сушеный базилик.", "Острая Мясная", "Баварская", "assets/Bavarian.png", (sbyte)1, 612m, 1 },
                    { 4, "Тесто дрожжевое, сыр Моцарелла, колбаски охотничьи, соус томатный, бастурма, колбаса пепперони (острая), масло чесночное, перец халапеньо, сушеный базилик.", "Острая Мясная", "Баварская", "assets/Bavarian.png", (sbyte)1, 562m, 2 },
                    { 5, "Тесто дрожжевое, сыр Моцарелла, куриное филе, соус цезарь, помидоры свежие, сыр пармезан, шампиньоны свежие, сливки, микс салат, сушеный базилик.", "Грибная", "Жюльен", "assets/Zhulien.png", (sbyte)1, 590m, 1 },
                    { 6, "Тесто дрожжевое, сыр Моцарелла, куриное филе, соус цезарь, помидоры свежие, сыр пармезан, шампиньоны свежие, сливки, микс салат, сушеный базилик.", "Грибная", "Жюльен", "assets/Zhulien.png", (sbyte)1, 445m, 2 },
                    { 7, "Тесто дрожжевое, сыр Моцарелла, семга, соус фирменный (лечо, майонез), креветки, лук репчатый красный, сушеный базилик.", "Рыбная", "Золотая рыбка", "assets/GoldenFish.png", (sbyte)1, 840m, 1 },
                    { 8, "Тесто дрожжевое, сыр Моцарелла, семга, соус фирменный (лечо, майонез), креветки, лук репчатый красный, сушеный базилик.", "Рыбная", "Золотая рыбка", "assets/GoldenFish.png", (sbyte)1, 670m, 2 },
                    { 9, "Тесто дрожжевое, сыр Моцарелла, ветчина, соус \"Гриль-Бургер\", куриное филе, перец сладкий болгарский, соус сладкий чили, колбаса пепперони (острая), лук репчатый красный, зелень рукколы.", "Острая мясная", "Пиццбургер", "assets/PizzaBurger.png", (sbyte)1, 730m, 1 },
                    { 10, "Тесто дрожжевое, сыр Моцарелла, ветчина, соус \"Гриль-Бургер\", куриное филе, перец сладкий болгарский, соус сладкий чили, колбаса пепперони (острая), лук репчатый красный, зелень рукколы.", "Острая мясная", "Пиццбургер", "assets/PizzaBurger.png", (sbyte)1, 540m, 2 }
                });

            migrationBuilder.InsertData(
                table: "basket",
                columns: new[] { "Id", "Amount", "PizzaId", "Price", "UserId" },
                values: new object[] { 1, 1, 1, 0m, 1 });

            migrationBuilder.InsertData(
                table: "orderString",
                columns: new[] { "Id", "Count", "OrderId", "PizzaId" },
                values: new object[,]
                {
                    { 1, 1, 1, 1 },
                    { 2, 1, 2, 1 },
                    { 3, 1, 3, 1 }
                });

            migrationBuilder.CreateIndex(
                name: "pizza_idx",
                table: "basket",
                column: "PizzaId");

            migrationBuilder.CreateIndex(
                name: "user_idx",
                table: "basket",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "client_idx",
                table: "order",
                column: "ClientId");

            migrationBuilder.CreateIndex(
                name: "courier_idx",
                table: "order",
                column: "CourierId");

            migrationBuilder.CreateIndex(
                name: "status_idx",
                table: "order",
                column: "StatusId");

            migrationBuilder.CreateIndex(
                name: "worker_idx",
                table: "order",
                column: "WorkerId");

            migrationBuilder.CreateIndex(
                name: "order_idx",
                table: "orderString",
                column: "OrderId");

            migrationBuilder.CreateIndex(
                name: "pizza_idx1",
                table: "orderString",
                column: "PizzaId");

            migrationBuilder.CreateIndex(
                name: "size_idx",
                table: "pizza",
                column: "SizeId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "basket");

            migrationBuilder.DropTable(
                name: "orderString");

            migrationBuilder.DropTable(
                name: "order");

            migrationBuilder.DropTable(
                name: "pizza");

            migrationBuilder.DropTable(
                name: "user");

            migrationBuilder.DropTable(
                name: "status");

            migrationBuilder.DropTable(
                name: "size");
        }
    }
}
