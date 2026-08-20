# Uber Ride Analytics: Business Analytics Using Power BI, R & Python

## 📌 Project Overview

This project applies Business Analytics techniques to Uber ride data to understand ride patterns, pricing behaviour, customer preferences, operational performance, and revenue trends.

The project integrates three major analytical approaches:

- 📊 Power BI – Interactive Business Intelligence dashboards
- 📈 R – Statistical analysis, correlation analysis, regression modelling, and visualisation
- 🤖 Python – Machine Learning, customer segmentation, and association rule mining

The objective is to generate actionable business insights that can support data-driven decisions related to ride efficiency, pricing strategies, customer behaviour, and service optimisation.

---

## 🎯 Objectives

The key objectives of this project are:

1. Analyse Uber trip and ride-level data.
2. Identify patterns in ride demand, pricing, distance, and customer behaviour.
3. Develop interactive Power BI dashboards for business performance analysis.
4. Perform statistical analysis using R.
5. Build regression models to understand relationships between trip attributes and fare/duration.
6. Apply Machine Learning techniques for payment method prediction and customer segmentation.
7. Identify frequent patterns and relationships using Association Rule Mining.
8. Translate analytical findings into actionable managerial insights.

---

## 📂 Dataset

The project uses Uber ride datasets containing three major sheets:

### 1. Location Table
- 265 locations
- Location ID
- Location
- City

### 2. Trip Details
- 103,728 trip records
- Trip ID
- Pickup and Drop-off Time
- Passenger Count
- Trip Distance
- Pickup and Drop-off Location
- Fare Amount
- Surge Fee
- Vehicle
- Payment Type

### 3. Uber Rides Data
- 1,141 ride records
- Start and End Locations
- Miles
- Duration
- Purpose
- Category
- Date and Time information

The datasets capture trip-level, geographical, pricing, operational, and behavioural information.

---

# 📊 Power BI Dashboard

The Power BI component contains an interactive Uber Ride Analytics Dashboard with multiple analytical views.

### Dashboard Sections

- Uber Trips Details Executive Summary
- Uber Trips Performance Analysis
- Uber Rides Data Executive Summary
- Uber Rides Performance & Behaviour Insights

### Key KPIs

The dashboards analyse metrics such as:

- Total Trips
- Total Distance
- Total Revenue
- Average Fare
- Total Surge
- Total Miles
- Average Miles per Trip
- Average Speed
- Total Duration

### Key Analysis Areas

- Revenue trends
- Vehicle performance
- Payment type distribution
- Peak-hour demand
- Passenger behaviour
- Business vs Personal rides
- Trip purpose
- Miles and duration
- Speed trends
- Demand patterns

---

# 📈 Statistical Analysis Using R

R was used to perform statistical analysis on the Uber datasets.

### Data Preparation

The R analysis included:

- Data cleaning
- Column name standardisation
- Missing value treatment
- Duplicate removal
- Invalid record filtering
- Feature engineering

New variables such as:

- `fare_per_mile`
- `speed`

were created during the analysis.

### Statistical Techniques

The analysis included:

- Descriptive statistics
- Correlation analysis
- Multiple linear regression
- Regression diagnostics
- Multicollinearity analysis
- Data visualisation

### Key Findings

A strong positive relationship was observed between:

**Trip Distance and Fare**

Correlation:

`r = 0.975`

A strong relationship was also observed between:

**Miles and Duration**

Correlation:

`r = 0.837`

The regression analysis showed strong explanatory power for selected models.

---

# 🤖 Machine Learning Using Python

Machine Learning analysis was conducted using Python.

### Techniques Used

#### 1. Decision Tree Classification

Used to predict customer payment method preference.

**Target Variable:**
- Payment Type

**Key Features:**
- Trip Distance
- Passenger Count
- Fare Amount
- Surge Fee
- Pickup Hour
- Trip Duration
- Vehicle
- Fare per Mile

---

#### 2. K-Means Clustering

K-Means clustering was used to segment customers/trips into behavioural groups based on characteristics such as distance and fare.

The clustering analysis helps identify different ride behaviour segments that can support targeted pricing and service strategies.

---

#### 3. Association Rule Mining

The Apriori algorithm was used to identify frequent combinations and relationships among:

- Vehicle Type
- Payment Type
- Distance Category
- Fare Category

Continuous variables such as distance and fare were converted into categorical ranges before applying Association Rule Mining.

---

# 🔍 Key Business Insights

The analysis generated several important business insights.

### Demand Patterns

Ride demand is concentrated during commuting hours, particularly during morning and evening peak periods. This indicates the importance of dynamic driver allocation and demand-based pricing.

### Vehicle Performance

UberX represents the largest share of trips and revenue, highlighting strong demand for affordable ride options.

### Payment Behaviour

Digital payments, particularly Uber Pay, represent a major share of transactions, while cash remains an important payment method.

### Pricing

Trip distance has a very strong relationship with fare, indicating that distance is a major driver of pricing.

### Customer Behaviour

Business rides dominate the Uber Rides dataset, indicating strong potential for corporate mobility partnerships and enterprise travel solutions.

### Operational Efficiency

Afternoon periods show high demand but relatively lower average speed, indicating the impact of congestion on operational efficiency.

---

# 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Power BI | Interactive dashboards and business intelligence |
| R | Statistical analysis and regression |
| Python | Machine Learning and association analysis |
| Pandas | Data manipulation |
| Scikit-learn | Machine Learning |
| MLxtend | Association Rule Mining |
| Excel | Data storage and initial dataset |
| Google Colab | Python ML environment |

