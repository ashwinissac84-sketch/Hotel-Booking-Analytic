# Hotel Booking & Cancellation Intelligence

A data analytics project focused on analyzing hotel booking patterns, customer behavior, cancellation trends, seasonal demand, and estimated revenue using Python, SQL, PostgreSQL, and Streamlit.

## Project Overview

This project analyzes hotel booking data to identify business insights that can help hotels understand customer behavior, reduce booking cancellations, and improve business performance.

The analysis uses **87,396 cleaned hotel booking records** and combines Python-based exploratory data analysis, SQL business analysis, and an interactive Streamlit dashboard.

## Project Objectives

- Analyze hotel booking and cancellation patterns.
- Compare City Hotel and Resort Hotel performance.
- Identify seasonal booking trends.
- Understand customer segmentation and booking behavior.
- Analyze cancellation rates across different market segments.
- Evaluate estimated revenue and average daily rates.
- Build an interactive dashboard for business insights.

## Technologies Used

| Category | Technologies |
|---|---|
| Programming | Python |
| Data Analysis | Pandas, NumPy |
| Data Visualization | Matplotlib, Seaborn |
| Database | PostgreSQL |
| Query Language | SQL |
| Dashboard | Streamlit |
| Database Connectivity | Psycopg2 |
| Development Environment | Jupyter Notebook, VS Code |
| Version Control | Git, GitHub |

## Project Structure

```text
Hotel-Booking-Analytics/
│
├── data/
│   ├── hotel_bookings.csv
│   └── cleaned_hotel_bookings.csv
│
├── notebooks/
│   └── hotel_booking_analysis.ipynb
│
├── sql/
│   └── hotel_booking_analysis.sql
│
├── visualizations/
│
├── dashboard/
│   └── app.py
│
├── reports/
│
├── README.md
├── requirements.txt
└── .gitignore
```

## Dataset

**Dataset:** Hotel Booking Demand

**Source:** Kaggle – Jesse Mostipak

Dataset link: https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand

Original dataset contains approximately 119,390 records and 32 columns.

After removing duplicate records and handling missing values, the analytical dataset contains 87,396 records.

## Data Analysis Performed

### Python – Exploratory Data Analysis

- Dataset inspection and preprocessing.
- Duplicate removal and missing-value handling.
- Feature engineering.
- Booking and cancellation analysis.
- Hotel performance comparison.
- Monthly booking and revenue trends.
- Customer segmentation.
- Data visualization using Matplotlib and Seaborn.

### SQL – Business Analysis

The project includes 12 business-focused SQL analyses:

1. Overall booking and cancellation analysis.
2. Cancellation rate by hotel.
3. Monthly booking analysis.
4. Cancellation rate by market segment.
5. Booking lead time vs cancellation.
6. Cancellation rate by customer type.
7. Repeat guests vs first-time guests.
8. Top 10 countries by booking volume.
9. Estimated revenue analysis by hotel.
10. Average length of stay by hotel.
11. Deposit type vs cancellation rate.
12. Special requests analysis.

## Key Business Insights

- Overall booking cancellation rate: **27.49%**.
- City Hotel cancellation rate: **30.04%**.
- Resort Hotel cancellation rate: **23.48%**.
- August recorded the highest booking volume.
- Repeat guests had a cancellation rate of only **7.64%**, compared with **28.30%** for first-time guests.
- Transient customers represented the largest customer segment.
- Resort Hotel guests had a longer average stay of **4.39 nights**, compared with **3.15 nights** at City Hotel.

## Interactive Streamlit Dashboard

The dashboard connects directly to PostgreSQL and provides:

- Business KPI cards.
- Monthly booking trends.
- Hotel performance comparison.
- Cancellation analysis by market segment.
- Customer segmentation.
- Country-wise booking analysis.
- Interactive hotel, arrival-year, and booking-status filters.

## Running the Project Locally

### 1. Clone the repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
cd Hotel-Booking-Analytics
```

### 2. Create a virtual environment

```bash
python -m venv .venv
```

### 3. Activate the environment

Windows PowerShell:

```powershell
.\.venv\Scripts\Activate.ps1
```

### 4. Install dependencies

```bash
pip install -r requirements.txt
```

### 5. Configure PostgreSQL

- Install PostgreSQL and pgAdmin.
- Create a database named `hotel_booking_analytics`.
- Create the `hotel_bookings` table using the SQL schema.
- Import the cleaned CSV dataset into PostgreSQL.

### 6. Launch the dashboard

```bash
streamlit run dashboard/app.py
```

Open the local Streamlit URL displayed in your terminal.

## Important Notes

- Estimated revenue is calculated using ADR × total nights. It is an analytical estimate, not verified actual hotel revenue.
- Cancellation patterns represent observed associations and do not establish causation.
- The original dataset is available through the Kaggle source linked above.

## Author

**Ashwin Issac L**

Data Analytics | Python | SQL | PostgreSQL | Streamlit

---

*This project demonstrates practical data cleaning, exploratory analysis, SQL querying, data visualization, database connectivity, and interactive dashboard development.*