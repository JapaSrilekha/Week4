using System;

class Calculator
{
    // Method for Addition
    public int Add(int a, int b)
    {
        return a + b;
    }

    // Method for Subtraction
    public int Subtract(int a, int b)
    {
        return a - b;
    }
}

class Program
{
    static void Main()
    {
        Calculator calc = new Calculator();

        int a = 100;
        int b = 5;

        int sum = calc.Add(a, b);
        int diff = calc.Subtract(a, b);

        Console.WriteLine("Addition = " + sum);
        Console.WriteLine("Subtraction = " + diff);
    }
}
