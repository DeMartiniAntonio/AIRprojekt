using System.ComponentModel.DataAnnotations;

namespace VendingMachineAPI.Models
{
    public class Login
    {
        [Key]
        public int Login_ID { get; set; }
        public int User_id { get; set; }
        public DateTime Date_time { get; set; }
    }
}
