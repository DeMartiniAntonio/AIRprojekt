using System.ComponentModel.DataAnnotations;

namespace VendingMachineAPI.Models
{
    public class Device
    {
        [Key]
        public int Device_ID { get; set; }
        public decimal Lat { get; set; }
        public decimal Long { get; set; }
        public int Stock { get; set; }
        public decimal Price { get; set; }
        public bool Active { get; set; }
    }
}
