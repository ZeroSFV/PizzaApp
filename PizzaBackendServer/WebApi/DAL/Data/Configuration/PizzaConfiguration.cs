using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Data.Configuration
{
    public class PizzaConfiguration : IEntityTypeConfiguration<Pizza>
    {
        public void Configure(EntityTypeBuilder<Pizza> builder)
        {
            builder.ToTable("pizza");

            builder.Property(e => e.Id).ValueGeneratedOnAdd();

            builder.HasIndex(e => e.SizeId, "size_idx");

            builder.Property(e => e.Name).HasMaxLength(50);
            
            builder.Property(e => e.Price).HasPrecision(8, 2);
            
            builder.Property(e => e.Description).HasMaxLength(256);
            
            builder.Property(e => e.Consistance).HasMaxLength(256);
            
            builder.Property(e => e.Photo).HasMaxLength(256);

            builder.HasOne(e => e.Size)
                .WithMany(p => p.Pizzas)
                .HasForeignKey(p => p.SizeId)
                .HasConstraintName("userFK");

            builder.HasData(
                new Pizza
                {
                    Id = 1,
                    Name = "Пепперони",
                    Price = 630,
                    Description = "Мясная",
                    Prescence = (sbyte)1,
                    Consistance = "Тесто дрожжевое, сыр Моцарелла, колбаса пепперони (острая), соус томатный, сушеный базилик.",
                    SizeId = 1,
                    Photo = "assets/Pepperoni.png"
                },
                new Pizza
                {
                    Id = 2,
                    Name = "Пепперони",
                    Price = 562,
                    Description = "Мясная",
                    Prescence = (sbyte)1,
                    Consistance = "Тесто дрожжевое, сыр Моцарелла, колбаса пепперони (острая), соус томатный, сушеный базилик.",
                    SizeId = 2,
                    Photo = "assets/Pepperoni.png"
                },
                new Pizza
                {
                    Id = 3,
                    Name = "Баварская",
                    Price = 612,
                    Description = "Острая Мясная",
                    Prescence = (sbyte)1,
                    Consistance = "Тесто дрожжевое, сыр Моцарелла, колбаски охотничьи, соус томатный, бастурма, колбаса пепперони (острая), масло чесночное, перец халапеньо, сушеный базилик.",
                    SizeId = 1,
                    Photo = "assets/Bavarian.png"
                },
                new Pizza
                {
                    Id = 4,
                    Name = "Баварская",
                    Price = 562,
                    Description = "Острая Мясная",
                    Prescence = (sbyte)1,
                    Consistance = "Тесто дрожжевое, сыр Моцарелла, колбаски охотничьи, соус томатный, бастурма, колбаса пепперони (острая), масло чесночное, перец халапеньо, сушеный базилик.",
                    SizeId = 2,
                    Photo = "assets/Bavarian.png"
                },
                new Pizza
                {
                    Id = 5,
                    Name = "Жюльен",
                    Price = 590,
                    Description = "Грибная",
                    Prescence = (sbyte)1,
                    Consistance = "Тесто дрожжевое, сыр Моцарелла, куриное филе, соус цезарь, помидоры свежие, сыр пармезан, шампиньоны свежие, сливки, микс салат, сушеный базилик.",
                    SizeId = 1,
                    Photo = "assets/Zhulien.png"
                },
                new Pizza
                {
                    Id = 6,
                    Name = "Жюльен",
                    Price = 445,
                    Description = "Грибная",
                    Prescence = (sbyte)1,
                    Consistance = "Тесто дрожжевое, сыр Моцарелла, куриное филе, соус цезарь, помидоры свежие, сыр пармезан, шампиньоны свежие, сливки, микс салат, сушеный базилик.",
                    SizeId = 2,
                    Photo = "assets/Zhulien.png"
                },
                new Pizza
                {
                    Id = 7,
                    Name = "Золотая рыбка",
                    Price = 840,
                    Description = "Рыбная",
                    Prescence = (sbyte)1,
                    Consistance = "Тесто дрожжевое, сыр Моцарелла, семга, соус фирменный (лечо, майонез), креветки, лук репчатый красный, сушеный базилик.",
                    SizeId = 1,
                    Photo = "assets/GoldenFish.png"
                },
                new Pizza
                {
                    Id = 8,
                    Name = "Золотая рыбка",
                    Price = 670,
                    Description = "Рыбная",
                    Prescence = (sbyte)1,
                    Consistance = "Тесто дрожжевое, сыр Моцарелла, семга, соус фирменный (лечо, майонез), креветки, лук репчатый красный, сушеный базилик.",
                    SizeId = 2,
                    Photo = "assets/GoldenFish.png"
                },
                new Pizza
                {
                    Id = 9,
                    Name = "Пиццбургер",
                    Price = 730,
                    Description = "Острая мясная",
                    Prescence = (sbyte)1,
                    Consistance = "Тесто дрожжевое, сыр Моцарелла, ветчина, соус \"Гриль-Бургер\", куриное филе, перец сладкий болгарский, соус сладкий чили, колбаса пепперони (острая), лук репчатый красный, зелень рукколы.",
                    SizeId = 1,
                    Photo = "assets/PizzaBurger.png"
                },
                new Pizza
                {
                    Id = 10,
                    Name = "Пиццбургер",
                    Price = 540,
                    Description = "Острая мясная",
                    Prescence = (sbyte)1,
                    Consistance = "Тесто дрожжевое, сыр Моцарелла, ветчина, соус \"Гриль-Бургер\", куриное филе, перец сладкий болгарский, соус сладкий чили, колбаса пепперони (острая), лук репчатый красный, зелень рукколы.",
                    SizeId = 2,
                    Photo = "assets/PizzaBurger.png"
                }
                );
        }

    }
}
