namespace VendingMachineAPI.Models
{
    public class DeviceRequest
    {
        public decimal Lat { get; set; }
        public decimal Long { get; set; }
        public int Stock { get; set; }
        public decimal Price { get; set; }
        public bool Active { get; set; }
    }
}
