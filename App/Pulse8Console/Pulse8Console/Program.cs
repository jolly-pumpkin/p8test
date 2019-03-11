using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using DataAccess.Models;
using DataAccess.Queries;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Pulse8Console
{
    class Program
    {
        static void Main(string[] args)
        {
            //Setup Configurations
            var builder = new ConfigurationBuilder()
               .SetBasePath(Directory.GetCurrentDirectory())
               .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);

            IConfiguration config = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json", true, true)
                .Build();

            //Setup DI
            var serviceProvider = new ServiceCollection()
                .BuildServiceProvider();

            
            //Code!


            Console.WriteLine("Pulse8 app, please enter an memeber ID to get info, or enter \"stop\" to end programe");
            bool run = true;

            while (run)
            {
                Console.WriteLine("Please enter a member id: ");

                string input = Console.ReadLine().ToLower();

                if (input == "stop")
                {
                    run = false;
                }
                else
                {
                    try
                    {
                        int memberID = Convert.ToInt32(input);
                        using (IDbConnection connection = new SqlConnection(config["ConnectionString:Pulse8TestDB"]))
                        {
                            GetMember gm = new GetMember(memberID);
                            Member m  = gm.Execute(connection);

                            if(m != null)
                            {
                                GetMemberDiagnoses gmd = new GetMemberDiagnoses(memberID);
                                List<MemberDiagnosis> diagnoises = gmd.Execute(connection);
                            }

                        }
                    }
                    catch (FormatException ex)
                    {
                        Console.WriteLine("Please enter a valid integar for a member id: ");
                    }
                }
            }

            Console.WriteLine("Finished");
            Console.ReadLine();
        }
    }
}
