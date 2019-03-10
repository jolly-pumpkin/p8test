using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Pulse8Console.Services
{
    public interface IMemberService
    {
        Task<bool> DoesMemberExist(int id);
    }
}
