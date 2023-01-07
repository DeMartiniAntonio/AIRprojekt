using System.ComponentModel.DataAnnotations;

namespace VendingMachineAPI.Models
{
    public class ActionType
    {
        [Key]
        public int Action_type_ID { get; set; }
        public string Type { get; set; }
    }
}
