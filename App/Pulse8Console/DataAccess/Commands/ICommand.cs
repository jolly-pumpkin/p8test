using System.Data;

namespace DataAccess.Commands
{
    public interface ICommand
    {
        void Execute(IDbConnection conncetion);
    }
}
