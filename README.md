# 📊 Customer Churn Prediction

## 🔍 Problem Statement

Customer churn is a critical business problem impacting revenue and growth.
This project aims to identify high-risk customers and uncover key drivers of churn to enable proactive retention strategies.

---

## 📁 Dataset

* Source: Telco Customer Dataset
* Records: ~7,043 customers
* Features: Demographics, account details, services, billing

---

## ⚙️ Approach

### 1. Data Validation & Cleaning

* Checked for missing values and inconsistent categories
* Converted categorical variables using encoding techniques
* Verified data types and distributions

### 2. Exploratory Data Analysis (EDA)

Key patterns identified:

* Customers with **month-to-month contracts** show significantly higher churn
* **Low tenure + high monthly charges** segment has the highest churn risk
* Customers without **value-added services (Tech Support, Online Security)** are more likely to churn

### 3. Feature Engineering

* Tenure segmentation (low / medium / high)
* Contract type grouping
* Derived risk-based customer segments

### 4. Modeling

Models used:

* Logistic Regression (baseline)
* Random Forest
* XGBoost

Evaluation Metrics:

* Accuracy
* Precision / Recall
* ROC-AUC

### 5. Threshold Optimization

* Adjusted classification threshold to balance recall vs precision
* Focused on **maximizing churn detection (business priority)**

---

## 📈 Key Insights

* Overall churn rate: ~26%
* High-risk segment:

  * Low tenure + Month-to-month + High charges
  * ~65–70% churn probability
* Long-term contract customers show significantly lower churn

---

## 💡 Business Recommendations

* 🎯 Target high-risk segment with retention offers
* 💰 Encourage long-term contracts via discounts
* 📞 Improve engagement for low-tenure customers (first 3–6 months critical)
* 📦 Bundle value-added services to reduce churn probability

---

## 🛠 Tools & Technologies
* Excel (data cleaning and preprocessing)
* Python (pandas, numpy, sklearn, xgboost)
* SQL (for data querying)
* Power BI (for dashboarding)

---

## 📌 Project Highlights

* End-to-end pipeline (EDA → Modeling → Business insights)
* Focus on **business impact, not just accuracy**
* Threshold tuning aligned with real-world decision-making

---

## 👤 Author

Rahul
