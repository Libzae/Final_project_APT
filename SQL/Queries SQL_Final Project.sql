USE final_project;
-- Count different email addresses for same IP
SELECT customerIPAddress, COUNT(DISTINCT customerEmail) AS unique_customers
FROM final_project
GROUP BY customerIPAddress
HAVING COUNT(DISTINCT customerEmail) > 1;
-- Identifying different email addresses for same IP
SELECT t.customerIPAddress, t.customerEmail
FROM final_project t
WHERE t.customerIPAddress IN (
    SELECT customerIPAddress
    FROM final_project
    GROUP BY customerIPAddress
    HAVING COUNT(DISTINCT customerEmail) > 1
)
ORDER BY t.customerIPAddress, t.customerEmail;


-- Multiple payment methods same email account
SELECT customerEmail, COUNT(DISTINCT paymentMethodId) AS num_payment_methods
FROM final_project
GROUP BY customerEmail
ORDER BY num_payment_methods DESC;

-- Payment method registration failures by client
SELECT customerEmail, SUM(paymentMethodRegistrationFailure) AS num_registration_failures
FROM final_project
GROUP BY customerEmail
ORDER BY num_registration_failures DESC;

-- High value transactions order DESC
SELECT customerEmail, transactionId, transactionAmount
FROM final_project
ORDER BY transactionAmount DESC
LIMIT 50;

-- Checking small amount purchases same client
DROP TEMPORARY TABLE IF EXISTS SmallPurchases;

CREATE TEMPORARY TABLE SmallPurchases AS
SELECT customerEmail, transactionAmount
FROM final_project
WHERE transactionAmount > 0 AND transactionAmount <= 15;
SELECT * FROM SmallPurchases;

-- Checking small amount purchases same client
CREATE TEMPORARY TABLE SmallPurchases AS
SELECT customerEmail, transactionAmount
FROM final_project
WHERE transactionAmount > 0 AND transactionAmount <= 15;

SELECT customerEmail, transactionAmount, COUNT(*) AS transactionCount
FROM SmallPurchases
GROUP BY customerEmail, transactionAmount
ORDER BY transactionCount DESC;

