-- Create database
CREATE DATABASE IF NOT EXISTS InventoryTracking;
USE InventoryTracking;

-- Create Suppliers table
CREATE TABLE IF NOT EXISTS Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    ContactEmail VARCHAR(255),
    ContactPhone VARCHAR(50),
    UNIQUE (SupplierName)
);

-- Create Employees table
CREATE TABLE IF NOT EXISTS Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50),
    Position VARCHAR(100),
    UNIQUE (Email)
);

-- Create Products table
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    SupplierID INT,
    QuantityInStock INT DEFAULT 0,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE SET NULL,
    UNIQUE (ProductName)
);

-- Create Orders table
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    EmployeeID INT,
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE SET NULL
);

-- Create OrderDetails table (Many-to-Many relationship between Orders and Products)
CREATE TABLE IF NOT EXISTS OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Insert some sample data into Suppliers
INSERT INTO Suppliers (SupplierName, ContactName, ContactEmail, ContactPhone)
VALUES 
    ('Tech Supplies Inc.', 'Alice Smith', 'alice@techsupplies.com', '123-456-7890'),
    ('Office Goods Co.', 'Bob Johnson', 'bob@officegoods.com', '987-654-3210');

-- Insert sample data into Employees
INSERT INTO Employees (FirstName, LastName, Email, PhoneNumber, Position)
VALUES
    ('John', 'Doe', 'johndoe@example.com', '555-1234', 'Inventory Manager'),
    ('Jane', 'Roe', 'janeroe@example.com', '555-5678', 'Sales Representative');

-- Insert sample data into Products
INSERT INTO Products (ProductName, SupplierID, QuantityInStock, Price)
VALUES
    ('Laptop', 1, 50, 799.99),
    ('Office Chair', 2, 200, 129.99),
    ('Monitor', 1, 75, 299.99);

-- Insert sample data into Orders
INSERT INTO Orders (EmployeeID, Status)
VALUES 
    (1, 'Shipped'),
    (2, 'Pending');

-- Insert sample data into OrderDetails (Many-to-Many Relationship)
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
    (1, 1, 2, 799.99),
    (1, 2, 1, 129.99),
    (2, 3, 5, 299.99);

