CREATE TABLE customer_churn (
    customerID TEXT,
    gender TEXT,
    SeniorCitizen INT,
    Partner TEXT,
    Dependents TEXT,
    tenure INT,
    PhoneService TEXT,
    MultipleLines TEXT,
    InternetService TEXT,
    OnlineSecurity TEXT,
    OnlineBackup TEXT,
    DeviceProtection TEXT,
    TechSupport TEXT,
    StreamingTV TEXT,
    StreamingMovies TEXT,
    Contract TEXT,
    PaperlessBilling TEXT,
    PaymentMethod TEXT,
    MonthlyCharges FLOAT,
    TotalCharges TEXT,
    Churn TEXT
);

SELECT COUNT(*) FROM customer_churn;

SELECT * FROM customer_churn LIMIT 10;

UPDATE customer_churn
SET TotalCharges = NULL
WHERE TRIM(TotalCharges) = '';

ALTER TABLE customer_churn
ALTER COLUMN TotalCharges TYPE DOUBLE PRECISION
USING TotalCharges::DOUBLE PRECISION;

SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn;

SELECT 
    CASE 
        WHEN tenure <= 12 THEN 'Low Engagement (≤12 months)'
        ELSE 'High Engagement (>12 months)'
    END AS customer_segment,
    
    COUNT(*) AS total_customers,
    
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage

FROM customer_churn
GROUP BY customer_segment;

SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn
GROUP BY Contract
ORDER BY churn_rate DESC;

SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;