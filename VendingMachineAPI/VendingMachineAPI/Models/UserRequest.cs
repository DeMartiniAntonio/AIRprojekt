namespace VendingMachineAPI.Models
{
    public class UserRequest
    {
        public string First_name { get; set; }
        public string Last_name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }

        public int Role_id { get; set; }
    }
}
