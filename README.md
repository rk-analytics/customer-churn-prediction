# 📊 Customer Churn Prediction

## 🔍 Problem Statement

Customer churn is a critical business problem impacting revenue and growth.
This project aims to identify high-risk customers and uncover key drivers of churn to enable proactive retention strategies.

---

## 🎯 Objective

* Predict customer churn using machine learning
* Identify high-risk customer segments
* Quantify revenue at risk
* Provide actionable retention strategies

---

## 📁 Dataset

* **Source:** Telco Customer Dataset
* **Records:** ~7,043 customers
* **Features:** Demographics, account details, services, billing

---

## ⚙️ Approach

### 1. Data Validation & Cleaning

* Checked for missing values (**no significant nulls found**)
* Validated categorical consistency (**no unexpected labels**)
* Verified numerical distributions and potential outliers
* Encoded categorical variables for modeling

---

### 2. Exploratory Data Analysis (SQL)

Performed EDA using SQL to analyze churn patterns across:

* Contract types
* Tenure groups
* Monthly charges

**Key Findings:**

* Customers with **month-to-month contracts** have significantly higher churn
* **Low tenure + high monthly charges** segment shows highest churn risk
* Lack of **value-added services (Tech Support, Online Security)** increases churn probability

---

### 3. Feature Engineering (Python)

* Created tenure-based segments (low / medium / high)
* Grouped contract types
* Derived risk-oriented features for modeling

---

### 4. Predictive Modeling (Python)

**Models implemented:**

* Logistic Regression (baseline)
* Random Forest
* XGBoost

**Evaluation metrics:**

* Accuracy
* Precision / Recall
* ROC-AUC

**Model Performance (Final Model):**

* ROC-AUC: ~0.84 *(update with actual value)*
* Recall (Churn class): ~0.78 *(update with actual value)*
* Precision: ~0.65 *(update with actual value)*

---

### 5. Threshold Optimization

* Tuned classification threshold to balance precision and recall
* Prioritized **higher recall** to maximize churn detection
* Reduced false negatives to ensure high-risk customers are not missed

---

### 6. Dashboard & Visualization (Power BI)

* Built an interactive dashboard to visualize:

  * Churn distribution
  * High-risk customer segments
* Enabled filtering by tenure, contract type, and charges

#### 📊 Dashboard Preview

![Customer Churn Dashboard](outputs/figures/dashboard.png)

**Key highlights:**

* Churn Rate: **26.54%**
* Revenue at Risk: **$139K (~30%)**
* High-risk customers contribute disproportionately to revenue loss

---

## 📈 Key Insights

* Overall churn rate: **~26%**

**High-risk segment characteristics:**

* Low tenure

* Month-to-month contracts

* High monthly charges

* **~65–70% churn probability**

* Long-term contract customers show significantly lower churn

* High-risk customers contribute **~30% of total revenue at risk (~$139K monthly)**

---

## 💡 Business Recommendations

* 🎯 Target high-risk customers with retention offers
* 💰 Encourage long-term contracts through pricing incentives
* 📞 Improve onboarding & engagement for low-tenure customers
* 📦 Bundle value-added services to reduce churn probability

---

## 📂 Repository Structure

* `sql/` → SQL-based EDA
* `notebook/` → Python modeling
* `dashboard/` → Power BI dashboard
* `outputs/` → Visualizations and figures

---

## 🚀 How to Run

```bash
git clone https://github.com/rk-analytics/customer-churn-prediction.git
cd customer-churn-prediction
pip install -r requirements.txt
jupyter notebook notebook/churn_modeling.ipynb
```

---

## 🛠 Tools & Technologies

* Excel (initial data validation and cleaning)
* Python 3.10+ (pandas, numpy, scikit-learn, xgboost)
* SQL (data querying and EDA)
* Power BI (dashboard)

---

## 📌 Project Highlights

* End-to-end pipeline (**SQL → Python → BI**)
* Focus on **business impact, not just model accuracy**
* Threshold tuning aligned with real-world decision-making

---

## 👤 Author

**Rahul**
