using System.Data;

namespace DataAccess.Queries
{
    /// <summary>
    /// Generic method to execute a query
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public interface IQuery<T>
    {
        T Execute(IDbConnection connection);
    }
}
