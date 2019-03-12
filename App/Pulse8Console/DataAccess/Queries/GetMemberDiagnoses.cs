using DataAccess.Models;
using System.Data;
using Dapper;
using System.Linq;
using System.Collections.Generic;

namespace DataAccess.Queries
{
    /// <summary>
    /// Query to get the most severe diagnosis per category for the specified member.
    /// </summary>
    public class GetMemberDiagnoses : IQuery<List<MemberDiagnosisDto>>
    {
        private readonly int _id;
        private readonly string query = @"SELECT 
                m.MemberID, 
                m.FirstName,
                m.LastName,
                msd.MostSevereDiagnosisId,
                d.DiagnosisDescription,
                c.DiagnosisCategoryID AS 'CategoryID',
                c.CategoryDescription,
                c.CategoryScore,
                COALESCE(msc.MostSevereCategory, 1) AS 'IsMostSevereCategory'
                FROM Member m
                LEFT JOIN
                    (
                        SELECT
                        md.MemberID, MIN(md.DiagnosisID) AS 'MostSevereDiagnosisId', dcm.DiagnosisCategoryID
                        FROM MemberDiagnosis md
                        LEFT JOIN DiagnosisCategoryMap dcm ON dcm.DiagnosisID = md.DiagnosisID
                        GROUP BY md.MemberID, dcm.DiagnosisCategoryID
                    )msd
                ON msd.MemberID = m.MemberID
                LEFT JOIN
                    (
                        SELECT
                        md.MemberID, dm.DiagnosisID, dm.DiagnosisCategoryID, COALESCE(msc.MostSevereCategory, 0) AS 'MostSevereCategory'
                        FROM MemberDiagnosis md
                        LEFT JOIN DiagnosisCategoryMap dm ON dm.DiagnosisID = md.DiagnosisID
                        LEFT JOIN(
                            SELECT
                            md.MemberID, MIN(dm.DiagnosisCategoryID) AS 'MostSevereCategoryId', 1 AS 'MostSevereCategory'
                            FROM MemberDiagnosis md
                            LEFT JOIN DiagnosisCategoryMap dm ON dm.DiagnosisID = md.DiagnosisID
                            GROUP BY md.MemberID
                            )msc
                        ON msc.MemberID = md.MemberID and dm.DiagnosisCategoryID = msc.MostSevereCategoryId
                    )msc
                ON msc.MemberID = m.MemberID and msc.DiagnosisID = msd.MostSevereDiagnosisId
                LEFT JOIN Diagnosis d ON msd.MostSevereDiagnosisId = d.DiagnosisID
                LEFT JOIN DiagnosisCategory c ON c.DiagnosisCategoryID = msc.DiagnosisCategoryID
                WHERE m.MemberID = @id";

        /// <summary>
        /// Provide the member id for the query
        /// </summary>
        /// <param name="id"></param>
        public GetMemberDiagnoses(int id)
        {
            _id = id;
        }

        /// <summary>
        /// Runs the query to retrive the most severe diagnsis for each category for the provided member id
        /// </summary>
        /// <param name="connection"></param>
        /// <returns></returns>
        public List<MemberDiagnosisDto> Execute(IDbConnection connection)
        {
            return connection.Query<MemberDiagnosisDto>(
                    query,
                    new { id = _id }
                ).ToList<MemberDiagnosisDto>();
        }
    }
}
