using System;

class Program
{
    static void Main()
    {
        Console.Write("Enter Name: ");
        string name = Console.ReadLine();

        Console.Write("Enter Marks: ");
        int marks = Convert.ToInt32(Console.ReadLine());

        if (marks < 0 || marks > 100)
        {
            Console.WriteLine("Invalid Marks Entered");
        }
        else
        {
            Console.WriteLine("Student: " + name);

            if (marks >= 80)
                Console.WriteLine("Grade: A");
            else if (marks >= 70)
                Console.WriteLine("Grade: B");
            else if (marks >= 60)
                Console.WriteLine("Grade: C");
            else if (marks >= 50)
                Console.WriteLine("Grade: D");
            else
                Console.WriteLine("Grade: Fail");
        }
    }
}
