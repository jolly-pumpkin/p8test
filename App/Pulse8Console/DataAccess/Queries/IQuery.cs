using System.Data;

namespace DataAccess.Queries
{
    public interface IQuery<T>
    {
        T Execute(IDbConnection connection);
    }
}
