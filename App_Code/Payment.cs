using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Class1 的摘要说明
/// </summary>
namespace OThinker.H3.Portal.Entity
{
    public class Payment
    {
        public string PaymentNo { get; set; }
        public string PaymentDate { get; set; }
        public string ExpirationDate { get; set; }
        public string RemindDate { get; set; }
        public string OperateRemark { get; set; }
        public string Currency { get; set; }
        public string PaymentAmount { get; set; }
        

    }
}