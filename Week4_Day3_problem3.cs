using System;

class Program
{
    static void Main()
    {
        Console.Write("Enter Name: ");
        string name = Console.ReadLine();

        Console.Write("Enter Salary: ");
        double salary = Convert.ToDouble(Console.ReadLine());

        Console.Write("Enter Experience: ");
        int exp = Convert.ToInt32(Console.ReadLine());

        double bonusRate;

        // Using if-else for bonus rules
        if (exp < 2)
            bonusRate = 0.05;
        else if (exp <= 5)
            bonusRate = 0.10;
        else
            bonusRate = 0.15;

        // Using ternary operator for bonus calculation
        double bonus = salary > 0 ? salary * bonusRate : 0;

        double finalSalary = salary + bonus;

        Console.WriteLine("\nEmployee: " + name);
        Console.WriteLine("Bonus: " + bonus.ToString("F2"));
        Console.WriteLine("Final Salary: " + finalSalary.ToString("F2"));
    }
}
