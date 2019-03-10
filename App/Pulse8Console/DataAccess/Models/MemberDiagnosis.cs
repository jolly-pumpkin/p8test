using System;
using System.Collections.Generic;
using System.Text;

namespace DataAccess.Models
{
    public class MemberDiagnosis
    {
        public int MemberId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int MostSevereDiagnosisId { get; set; }
        public string MostSevereDiagonosisDescription { get; set; }
        public int CategoryID { get; set; }
        public string CategoryDescription { get; set; }
        public int CategoryScore { get; set; }
        public bool IsMostSevereCategory { get; set; }
    }
}
