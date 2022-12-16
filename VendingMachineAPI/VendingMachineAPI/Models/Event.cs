using System.ComponentModel.DataAnnotations;

namespace VendingMachineAPI.Models
{
    public class Event
    {
        [Key]
        public int Event_ID { get; set; }
        public int User_id { get; set; }
        public int Device_id { get; set; }
        public DateTime Date_time { get; set; }
    }
}
