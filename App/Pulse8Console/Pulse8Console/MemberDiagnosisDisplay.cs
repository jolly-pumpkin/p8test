using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Pulse8Console
{
    public class MemberDiagnosisDisplay
    {
        public static void Display(List<MemberDiagnosis> memberDiagnoses)
        {
            Console.WriteLine("--------------------------------------------------");
            foreach(MemberDiagnosis diagnosis in memberDiagnoses)
            {
                Console.WriteLine($"Diagnosis report for member: {diagnosis.MemberId}");
                Console.WriteLine($"Member ID: {diagnosis.MemberId}");
                Console.WriteLine($"First Name: {diagnosis.FirstName}");
                Console.WriteLine($"First Name: {diagnosis.LastName}");
                Console.WriteLine($"Most Severe Diagnosis: {diagnosis.MostSevereDiagnosisId}");
                Console.WriteLine($"Diagnosis Description: {diagnosis.MostSevereDiagonosisDescription}");
                Console.WriteLine($"Category ID: {diagnosis.CategoryID}");
                Console.WriteLine($"Category Score: {diagnosis.CategoryScore}");
                Console.WriteLine($"First Name: {diagnosis.IsMostSevereCategory}");

            }

            Console.WriteLine("--------------------------------------------------");
        }
    }
}
