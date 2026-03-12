using System;

class Product
{
    // Private variables
    private int productId;
    private string productName = "";
    private double unitPrice;
    private int qty;

    // Constructor with productId parameter
    public Product(int id)
    {
        productId = id;
    }

    // Readonly property
    public int ProductId
    {
        get { return productId; }
    }

    // Property for ProductName
    public string ProductName
    {
        get { return productName; }
        set { productName = value; }
    }

    // Property for UnitPrice
    public double UnitPrice
    {
        get { return unitPrice; }
        set { unitPrice = value; }
    }

    // Property for Quantity
    public int Quantity
    {
        get { return qty; }
        set { qty = value; }
    }

    // Method to display details
    public void ShowDetails()
    {
        double total = unitPrice * qty;

        Console.WriteLine("Product Id: " + productId);
        Console.WriteLine("Product Name: " + productName);
        Console.WriteLine("Unit Price: " + unitPrice);
        Console.WriteLine("Quantity: " + qty);
        Console.WriteLine("Total Amount: " + total);
    }
}

class Program
{
    static void Main()
    {
        Product p = new Product(101);

        p.ProductName = "phone";
        p.UnitPrice = 50000;
        p.Quantity = 2;

        p.ShowDetails();
    }
}
