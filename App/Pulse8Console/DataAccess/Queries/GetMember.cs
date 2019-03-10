using DataAccess.Models;
using System.Data;
using Dapper;
using System.Linq;

namespace DataAccess.Queries
{
    public class GetMember : IQuery<Member>
    {
        private readonly int _id;

        public GetMember(int id)
        {
            _id = id;
        }

        public Member Execute(IDbConnection connection)
        {
            return connection.Query<Member>(
                "SELECT MemberID, FirstName, LastName FROM Member WHERE MemberID = @id",
                new { id = _id }).FirstOrDefault();
        }
    }
}
