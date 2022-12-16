namespace VendingMachineAPI.Models
{
    public class UpdateDeviceRequest
    {
        public decimal Lat { get; set; }
        public decimal Long { get; set; }
        public int Stock { get; set; }
        public decimal Price { get; set; }
        public string Active { get; set; }
    }
}
