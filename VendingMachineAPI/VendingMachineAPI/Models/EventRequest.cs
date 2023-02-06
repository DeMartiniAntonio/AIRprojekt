namespace VendingMachineAPI.Models
{
    public class EventRequest
    {
        public int User_id { get; set; }
        public int Device_id { get; set; }
        public DateTime Date_time { get; set; }
    }
}
