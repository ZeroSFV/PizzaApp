using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace DAL.Data.Configuration
{
    public class SizeConfiguration : IEntityTypeConfiguration<Size> 
    {
        public void Configure(EntityTypeBuilder<Size> builder)
        {
            builder.ToTable("size");

            builder.Property(e => e.Id).ValueGeneratedOnAdd();

            builder.Property(e => e.Name).HasMaxLength(50);

            builder.HasData(
                new Size
                {
                    Id = 1,
                    Name = "Большая"
                },
                new Size
                {
                    Id = 2,
                    Name = "Средняя"
                }
                );
        }
    }
}
