namespace DataAccess.Models
{
    /// <summary>
    /// Dto object for Get Member diagnoses query
    /// </summary>
    public class MemberDiagnosisDto
    {
        public int MemberId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int? MostSevereDiagnosisId { get; set; }
        public string MostSevereDiagonosisDescription { get; set; }
        public int? CategoryID { get; set; }
        public string CategoryDescription { get; set; }
        public int? CategoryScore { get; set; }
        public bool IsMostSevereCategory { get; set; }
    }
}
