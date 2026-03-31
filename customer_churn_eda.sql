USE churn_analysis;

-- To determine the total number of customers in the dataset.
SELECT 
COUNT(*) AS total_customers
FROM telco_customer_churn;
-- The dataset consists of 7,043 customers, providing a strong sample size for analyzing churn patterns and deriving statistically meaningful insights.

-- To validate the dataset by checking for missing values across key numeric features.
SELECT 
COUNT(*) AS total_rows,
SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END) AS missing_tenure,
SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END) AS missing_monthlycharges,
SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS missing_totalcharges
FROM telco_customer_churn;
-- No missing values are present in tenure, MonthlyCharges, or TotalCharges. Dataset is fully complete and analysis-ready.

-- To identify inconsistencies in billing by comparing TotalCharges with expected charges and quantify the extent of significant deviations.
SELECT 
COUNT(*) AS mismatch_count,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM telco_customer_churn),2) AS mismatch_pct,
ROUND(AVG(ABS(TotalCharges - (MonthlyCharges * tenure))),2) AS avg_error,
ROUND(MAX(ABS(TotalCharges - (MonthlyCharges * tenure))),2) AS max_error
FROM telco_customer_churn
WHERE ABS(TotalCharges - (MonthlyCharges * tenure)) > 100;
-- Approximately 12.4% of records show significant deviations (>100) between expected and actual total charges, with an average deviation of 150.83. These differences likely arise due to real-world billing factors such as discounts, partial billing cycles, or non-linear pricing structures.

-- To calculate the overall churn rate and total number of churned customers.
SELECT
COUNT(*) AS total_customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100,2
) AS churn_rate_percent
FROM telco_customer_churn;
-- Out of 7043 customers, 1869 churned, resulting in a 26.54% churn rate. About 1 in 4 customers leave the service

-- To evaluate how churn rate varies across contract types and identify high-risk segments.
SELECT
Contract,
COUNT(*) AS total_customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned,
ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100,2
) AS churn_rate
FROM telco_customer_churn
GROUP BY Contract
ORDER BY churn_rate DESC;
-- Month-to-month contracts have the highest churn rate (42.71%), followed by one-year (11.27%) and two-year (2.83%).

-- To evaluate churn along with segment size in order to identify high-impact customer segments.
SELECT 
Contract,
COUNT(*) AS customers,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM telco_customer_churn),2) AS segment_size_pct,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS churn_rate
FROM telco_customer_churn
GROUP BY Contract
ORDER BY segment_size_pct DESC;
-- Month-to-month customers form the largest segment (~55%) and also have the highest churn rate (42.71%).

-- To analyze how churn varies across different internet service types.
SELECT
InternetService,
COUNT(*) AS customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned,
ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100,2
) AS churn_rate
FROM telco_customer_churn
GROUP BY InternetService
ORDER BY churn_rate DESC;
-- Fiber optic users have the highest churn rate (41.89%), followed by DSL (18.96%), while customers without internet have the lowest churn (7.40%).

-- To analyze how churn varies across different payment methods.
SELECT 
PaymentMethod,
COUNT(*) AS customers,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS churn_rate
FROM telco_customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;
-- Customers using electronic check have the highest churn rate (45.29%), while automatic payment methods have significantly lower churn.

-- To evaluate how subscription to online security services impacts customer churn.
SELECT 
OnlineSecurity,
COUNT(*) AS customers, 
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS churn_rate
FROM telco_customer_churn
WHERE OnlineSecurity != 'No internet service'
GROUP BY OnlineSecurity;
-- Customers without online security show significantly higher churn (41.77%) compared to those with security (14.61%).

-- To analyze how availability of tech support impacts customer churn.
SELECT 
TechSupport,
COUNT(*) AS customers,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS churn_rate
FROM telco_customer_churn
WHERE TechSupport != 'No internet service'
GROUP BY TechSupport;
-- Customers without tech support have a much higher churn rate (41.64%) compared to those with support (15.17%).

-- To compare average monthly charges between churned and retained customers.
SELECT
Churn,
ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charge
FROM telco_customer_churn
GROUP BY Churn;
-- Churned customers pay higher average monthly charges (74.44) compared to retained customers (61.27).

-- To analyze how churn differs between high-value and low-value customers based on monthly charges.
SELECT 
CASE 
WHEN MonthlyCharges > 80 THEN 'High Value'
ELSE 'Low Value'
END AS customer_segment,
COUNT(*) AS customers,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS churn_rate
FROM telco_customer_churn
GROUP BY customer_segment;
-- High-value customers have a higher churn rate (33.98%) compared to low-value customers (22.00%).

-- To compare average customer tenure between churned and retained customers.
SELECT
Churn,
ROUND(AVG(tenure),2) AS avg_tenure
FROM telco_customer_churn
GROUP BY Churn;
-- Churned customers have significantly lower average tenure (17.98 months) compared to retained customers (37.57 months).

-- To analyze how churn varies across different customer tenure segments.
SELECT 
CASE 
WHEN tenure <= 12 THEN '0-1 Year'
WHEN tenure <= 24 THEN '1-2 Years'
WHEN tenure <= 48 THEN '2-4 Years'
ELSE '4+ Years'
END AS tenure_group,
COUNT(*) AS customers,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS churn_rate
FROM telco_customer_churn
GROUP BY tenure_group
ORDER BY churn_rate DESC;
-- Customers in the first year have the highest churn (47.44%), which steadily declines as tenure increases.

-- To measure revenue contribution and percentage of revenue at risk across contract types.
SELECT 
Contract,
ROUND(SUM(MonthlyCharges),2) AS total_revenue,
ROUND(SUM(CASE WHEN Churn='Yes' THEN MonthlyCharges ELSE 0 END),2) AS churn_revenue,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) * 100.0 / SUM(MonthlyCharges),2) AS churn_revenue_pct 
FROM telco_customer_churn
GROUP BY Contract
ORDER BY churn_revenue_pct DESC;
-- Month-to-month contracts have the highest revenue loss (~47%), while long-term contracts have significantly lower revenue risk.

-- To estimate the total monthly revenue lost due to churned customers.
SELECT
ROUND(SUM(MonthlyCharges),2) AS monthly_revenue_lost
FROM telco_customer_churn
WHERE Churn='Yes';
-- The business is losing approximately 139,130.85 in monthly revenue due to churn.

-- To estimate the total revenue lost from churned customers over their lifetime.
SELECT 
ROUND(SUM(MonthlyCharges * tenure),2) AS total_revenue_lost
FROM telco_customer_churn
WHERE Churn='Yes';
-- Total estimated revenue lost from churned customers is approximately 2,862,576.9.

-- To analyze how churn varies based on the combined effect of contract type and customer value (charges).
SELECT 
Contract,
CASE 
WHEN MonthlyCharges > 80 THEN 'High'
ELSE 'Low'
END AS charge_segment,
COUNT(*) AS customers,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS churn_rate
FROM telco_customer_churn
GROUP BY Contract, charge_segment;
-- High-value month-to-month customers have the highest churn (52.15%), while long-term low-value customers have the lowest churn.

-- To analyze how churn is influenced by the combined effect of contract type and customer tenure.
SELECT 
Contract,
CASE 
WHEN tenure <= 12 THEN '0-1 Year'
ELSE '1+ Year'
END AS tenure_group,
COUNT(*) AS customers,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS churn_rate
FROM telco_customer_churn
GROUP BY Contract, tenure_group
ORDER BY churn_rate DESC;
-- Month-to-month customers within their first year show the highest churn (51.35%), while long-term contract customers have significantly lower churn.

-- To identify high-risk customers using a combination of key churn drivers.
SELECT 
CASE 
WHEN tenure <= 12 
AND Contract = 'Month-to-month' 
AND MonthlyCharges > 70 
THEN 'High Risk'
ELSE 'Low Risk'
END AS risk_segment,
COUNT(*) AS customers,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS churn_rate
FROM telco_customer_churn
GROUP BY risk_segment;
-- The high-risk segment (856 customers) has a churn rate of 69.04%, significantly higher than the low-risk segment (20.66%).

