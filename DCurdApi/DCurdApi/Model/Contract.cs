using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DCurdApi.Model
{
    public class Contract
    {
        [Key]
        public int ContractID { get; set; }
        [DisplayName("Customer Name")]
        public string CustomerName { get; set; }
        public string Address { get; set; }
        public string Gender { get; set; }
        public string Country { get; set; }
        public string Age { get; set; }
        public DateTime Dateofbirth { get; set; }
        public DateTime SaleDate { get; set; }
        public string CoveragePlan { get; set; }
        public double NetPrice { get; set; }
    }
}
