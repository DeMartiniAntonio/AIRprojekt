using Microsoft.EntityFrameworkCore;
using VendingMachineAPI.Models;

namespace VendingMachineAPI.Data
{
    public class VendingMachineAPIDbContext : DbContext
    {
        public VendingMachineAPIDbContext(DbContextOptions options ) : base(options) 
        {
        }

        public DbSet<Device> Devices { get; set; }
        public DbSet<Event> Events { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<User> Users { get; set; }

        public DbSet<Login> Login { get; set; }


    }
}
