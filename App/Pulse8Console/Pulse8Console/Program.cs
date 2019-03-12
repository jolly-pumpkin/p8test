using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using DataAccess.Models;
using DataAccess.Queries;
using Microsoft.Extensions.Configuration;

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

            //Code!
            bool run = true;
            while (run)
            {
                Console.WriteLine("Please enter a member id or \"stop\"");

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
                            GetMemberDiagnoses gmd = new GetMemberDiagnoses(memberID);
                            List<MemberDiagnosisDto> diagnoises = gmd.Execute(connection);

                            if(diagnoises.Count > 0)
                            {
                                Display.MemberDiagnoses(diagnoises);
                            }
                            else
                            {
                                Console.WriteLine($"Member: {memberID} does not exist.");
                            }
                        }
                    }
                    catch (FormatException)
                    {
                        Console.WriteLine("Please enter a valid integer for a member id or \"stop\"");
                    }
                    catch(Exception ex)
                    {
                        Console.WriteLine($"Error: {ex.Message}");
                    }
                }
            }
            Console.WriteLine("Finished");
        }
    }
}
