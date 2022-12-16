using System.ComponentModel.DataAnnotations;

namespace VendingMachineAPI.Models
{
    public class Role
    {
        [Key]
        public int Role_ID { get; set; }
        public string Description { get; set; }
    }
}
