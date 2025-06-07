Table: TelcoCustomers
Columns: CustomerID, Gender, SeniorCitizen, Partner, Dependents, Tenure, PhoneServices, MultipleLines, InternetService, OnlineSecurity, OnlineBackup, DeviceProtection, TechSupport, StreamingTV, StreamingMovies, Contract, PaperlessBilling, PaymentMethod, MonthlyCharges, TotalCharges, Churn, NumberOfAddonServices
 
1. Overall Churn Rate of All Customers
SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Total_Churned,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_Rate_Percent
FROM TelcoCustomers;


2. Churn Rate by Internet Service and Contract Type
SELECT
    InternetService,
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_Rate_Percent
FROM TelcoCustomers
GROUP BY InternetService, Contract
ORDER BY InternetService, Contract;


3. Churn Rate by Payment Method and Internet Service
SELECT
    PaymentMethod,
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_Rate_Percent
FROM TelcoCustomers
GROUP BY PaymentMethod, InternetService
ORDER BY PaymentMethod, InternetService;


4. Churn Rate by Tenure Group
SELECT
    CASE 
        WHEN Tenure <= 11 THEN '0–11'
        WHEN Tenure <= 23 THEN '12–23'
        WHEN Tenure <= 35 THEN '24–35'
        WHEN Tenure <= 47 THEN '36–47'
        WHEN Tenure <= 59 THEN '48–59'
        ELSE '60+'
    END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_Rate_Percent
FROM TelcoCustomers
GROUP BY Tenure_Group
ORDER BY 
  CASE 
    WHEN Tenure_Group = '0–11' THEN 1
    WHEN Tenure_Group = '12–23' THEN 2
    WHEN Tenure_Group = '24–35' THEN 3
    WHEN Tenure_Group = '36–47' THEN 4
    WHEN Tenure_Group = '48–59' THEN 5
    ELSE 6
  END;


5. Demographic Doughnut Charts (Churn Counts)
-- Male churn distribution
SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Gender = 'Male' AND Churn = 'Yes' THEN 1 ELSE 0 END) AS Male_Churned,
    ROUND(100.0 * SUM(CASE WHEN Gender = 'Male' AND Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Male_Churn_Rate
FROM TelcoCustomers;

-- Female churn distribution
SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Gender = 'Female' AND Churn = 'Yes' THEN 1 ELSE 0 END) AS Female_Churned,
    ROUND(100.0 * SUM(CASE WHEN Gender = 'Female' AND Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Female_Churn_Rate
FROM TelcoCustomers;

-- Senior Citizen churn distribution
SELECT
    CASE WHEN SeniorCitizen = 1 THEN 'Senior' ELSE 'Non-Senior' END AS Senior_Status,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_Rate_Percent
FROM TelcoCustomers
GROUP BY Senior_Status;

-- Partner churn distribution
SELECT
    Partner,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_Rate_Percent
FROM TelcoCustomers
GROUP BY Partner;

-- Dependents churn distribution
SELECT
    Dependents,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_Rate_Percent
FROM TelcoCustomers
GROUP BY Dependents;


6. Monthly Charges Binning (by $50 increments) with Churn Rate
SELECT
    CASE
        WHEN MonthlyCharges <= 50 THEN '$0–50'
        WHEN MonthlyCharges <= 100 THEN '$51–100'
        ELSE '$101+'
    END AS MonthlyCharges_Bin,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_Rate_Percent
FROM TelcoCustomers
GROUP BY MonthlyCharges_Bin
ORDER BY 
  CASE MonthlyCharges_Bin
    WHEN '$0–50' THEN 1
    WHEN '$51–100' THEN 2
    ELSE 3
  END;


7. Total Charges Binning (by $1000 increments) with Churn Rate
SELECT
    CASE
        WHEN TotalCharges <= 1000 THEN '$0–1,000'
        WHEN TotalCharges <= 2000 THEN '$1,001–2,000'
        WHEN TotalCharges <= 3000 THEN '$2,001–3,000'
        WHEN TotalCharges <= 4000 THEN '$3,001–4,000'
        WHEN TotalCharges <= 5000 THEN '$4,001–5,000'
        WHEN TotalCharges <= 6000 THEN '$5,001–6,000'
        WHEN TotalCharges <= 7000 THEN '$6,001–7,000'
        WHEN TotalCharges <= 8000 THEN '$7,001–8,000'
        ELSE '$8,001+'
    END AS TotalCharges_Bin,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_Rate_Percent
FROM TelcoCustomers
GROUP BY TotalCharges_Bin
ORDER BY MIN(TotalCharges);
