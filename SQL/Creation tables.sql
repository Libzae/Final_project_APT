USE FINAL_PROJECT_tables;
CREATE TABLE Customers (
    customerEmail VARCHAR(255) PRIMARY KEY,
    customerPhone VARCHAR(255),
    customerDevice VARCHAR(255),
    customerIPAddress VARCHAR(255),
    customerBillingAddress VARCHAR(255));
    
CREATE TABLE Orders (
    orderId VARCHAR(255) PRIMARY KEY,
    orderState VARCHAR(255),
    customerEmail VARCHAR(255),
    FOREIGN KEY (customerEmail) REFERENCES Customers(customerEmail)
);

CREATE TABLE PaymentMethods (
    paymentMethodId VARCHAR(255) PRIMARY KEY,
    paymentMethodRegistrationFailure BOOLEAN,
    paymentMethodType VARCHAR(255),
    paymentMethodProvider VARCHAR(255)
);
  
CREATE TABLE Transactions (
    transactionId VARCHAR(255) PRIMARY KEY,
    transactionAmount FLOAT,
    transactionFailed BOOLEAN,
    orderId VARCHAR(255),
    paymentMethodId VARCHAR(255),
    FOREIGN KEY (orderId) REFERENCES Orders(orderId),
    FOREIGN KEY (paymentMethodId) REFERENCES PaymentMethods(paymentMethodId));