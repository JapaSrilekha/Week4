using System;

class Student
{
    // Method to calculate average
    public double CalculateAverage(int m1, int m2, int m3)
    {
        double avg = (m1 + m2 + m3) / 3.0;
        return avg;
    }

    // Method to determine grade
    public string GetGrade(double avg)
    {
        if (avg >= 80)
            return "A";
        else if (avg >= 60)
            return "B";
        else if (avg >= 50)
            return "C";
        else
            return "F";
    }
}

class Program
{
    static void Main()
    {
        Student s = new Student();

        int m1 = 50;
        int m2 = 70;
        int m3 = 90;

        double average = s.CalculateAverage(m1, m2, m3);
        string grade = s.GetGrade(average);

        Console.WriteLine("Average = " + average);
        Console.WriteLine("Grade = " + grade);
    }
}
