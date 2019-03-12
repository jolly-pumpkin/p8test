using System.Data;

namespace DataAccess.Commands
{
    /// <summary>
    /// Generic method to execute a command
    /// </summary>
    public interface ICommand
    {
        void Execute(IDbConnection conncetion);
    }
}
