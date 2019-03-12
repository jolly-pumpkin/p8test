using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Pulse8Console
{
    public class Display
    {
        /// <summary>
        /// Prints all the diagonises associated with a member.
        /// </summary>
        /// <param name="memberDiagnoses"></param>
        public static void MemberDiagnoses(List<MemberDiagnosisDto> diagnoses)
        {
            Console.WriteLine("--------------------------------------------------");
            Console.WriteLine($"Diagnosis report for member: {diagnoses[0].MemberId}");
            int count = 1;
            foreach(MemberDiagnosisDto diagnosis in diagnoses)
            {
                Console.WriteLine($"Diagnosis {count} of {diagnoses.Count}");
                Console.WriteLine("*********************************");
                Console.WriteLine($"Member ID: {diagnosis.MemberId}");
                Console.WriteLine($"First Name: {diagnosis.FirstName}");
                Console.WriteLine($"Last Name: {diagnosis.LastName}");
                Console.WriteLine($"Most Severe Diagnosis: {diagnosis.MostSevereDiagnosisId}");
                Console.WriteLine($"Diagnosis Description: {diagnosis.MostSevereDiagonosisDescription}");
                Console.WriteLine($"Category ID: {diagnosis.CategoryID}");
                Console.WriteLine($"Category Score: {diagnosis.CategoryScore}");
                Console.WriteLine($"Is Most Severe Category: {diagnosis.IsMostSevereCategory}\n");
                count++;
            }

            Console.WriteLine("--------------------------------------------------");
        }
    }
}
