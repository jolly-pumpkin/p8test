using DataAccess.Models;
using System.Data;
using Dapper;
using System.Linq;

namespace DataAccess.Queries
{
    public class GetMemberDiagnoses : IQuery<MemberDiagnosis>
    {
        private readonly int _id;

        public GetMemberDiagnoses(int id)
        {
            _id = id;
        }

        public MemberDiagnosis Execute(IDbConnection connection)
        {
            return connection.Query<MemberDiagnosis>(
                "SELECT MemberID, FirstName, LastName FROM Member WHERE MemberID = @id",
                new { id = _id }).FirstOrDefault();
        }
    }
}
