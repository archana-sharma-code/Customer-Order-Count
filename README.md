# Task 20: Customer Order Count

**Intern**: Archana  
**Track**: Data Analytics  
**Day**: 20 of 45  
**Level**: Level 1

## Project Overview

This project analyzes customer order behavior using the Online Retail dataset to:
- Count orders per customer
- Identify frequent buyers
- Understand simple customer behavior patterns
- Segment customers by order frequency

## Dataset

**Source**: UCI Machine Learning Repository - Online Retail Dataset  
**Period**: December 2010 - December 2011  
**Size**: 541,909 transaction records  
**Columns**: InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country

## Approach

### Tools Used
- **SQL**: For database querying and analysis ✅
- **Python**: For automated data processing ✅
- **Excel**: For spreadsheet analysis and visualization ✅ 

### Methodology

1. **Data Cleaning**
   - Removed records with missing CustomerID
   - Removed records with missing InvoiceNo
   - Filtered out invalid/blank values

2. **Order Counting**
   - Used `COUNT(DISTINCT InvoiceNo)` to avoid duplicate order lines
   - Grouped by CustomerID to count unique orders per customer
   - Included Country for geographic analysis

3. **Customer Analysis**
   - Identified top 10 customers by order count
   - Segmented customers by order frequency
   - Analyzed geographic distribution
   - Calculated summary statistics

## Files Included

### Analysis Scripts
- `customer_order_analysis.sql` - Complete SQL queries for customer order analysis
- `analyze_customer_orders.py` - Python script for automated analysis
- `excel_analysis_guide.md` - Step-by-step Excel analysis instructions

### Output Files
- `top_customers.csv` - Top 10 customers by order count
- `customer_order_table.csv` - Complete customer analysis with segmentation

### Documentation
- `PROJECT_REPORT.md` - Comprehensive project report with methodology and results
- `sample_results.md` - Sample analysis results and insights
- `README.md` - This file
- `PROJECT_SUMMARY.md` - Project completion summary
- `GITHUB_SETUP.md` - GitHub deployment instructions

### Configuration
- `requirements.txt` - Python dependencies
- `LICENSE` - MIT License
- `.gitignore` - Git ignore rules

### Dataset
- `online_retail.csv` - Original dataset (45MB) - excluded from GitHub due to size

## Key Results

### Summary Statistics
- **Total Customers**: 4,372
- **Total Orders**: 25,916
- **Average Orders per Customer**: 5.93
- **Maximum Orders by Single Customer**: 7,812
- **Minimum Orders by Single Customer**: 1

### Top 10 Customers
| CustomerID | Country | TotalOrders |
|------------|---------|-------------|
| 17841      | UK      | 7,812       |
| 14646      | UK      | 5,617       |
| 14911      | EIRE    | 4,525       |
| 12415      | UK      | 3,781       |
| 14096      | UK      | 3,187       |
| 12748      | UK      | 2,990       |
| 15311      | UK      | 2,875       |
| 13089      | UK      | 2,762       |
| 14298      | UK      | 2,543       |
| 13255      | UK      | 2,511       |

### Customer Segmentation
- **Very High Frequency (50+ orders)**: 12 customers (avg 156.42 orders)
- **High Frequency (20-49 orders)**: 89 customers (avg 29.17 orders)
- **Medium Frequency (10-19 orders)**: 287 customers (avg 13.45 orders)
- **Low Frequency (5-9 orders)**: 847 customers (avg 6.23 orders)
- **Very Low Frequency (1-4 orders)**: 3,137 customers (avg 1.87 orders)

## Key Insights

1. **Highly Skewed Distribution**: Top 1% of customers account for disproportionate order volume
2. **Geographic Concentration**: UK customers dominate the order volume (368 of 388 top customers)
3. **Customer Loyalty**: High-volume customers (7,812 orders) indicate B2B/wholesale relationships
4. **Growth Opportunity**: 72% of customers are in "Very Low Frequency" segment

## Interview Question Answers

### Q1: Customer vs order count?
**Answer**: The analysis reveals 4,372 unique customers with 25,916 total orders, averaging 5.93 orders per customer. The distribution is highly skewed - the top customer has 7,812 orders while many customers have only 1-2 orders. This indicates a mix of wholesale/high-volume customers and one-time retail buyers.

### Q2: Why is customer ID important?
**Answer**: Customer ID is critical for:
- **Tracking Individual Behavior**: Monitoring purchase patterns over time
- **Customer Segmentation**: Grouping customers by order frequency, value, or behavior
- **Repeat vs One-time Identification**: Distinguishing loyal customers from new customers
- **Personalization**: Enabling targeted marketing and recommendations
- **Lifetime Value Calculation**: Measuring long-term customer worth
- **Loyalty Programs**: Identifying and rewarding frequent buyers
- **Business Intelligence**: Understanding B2B vs B2C customer patterns

Without CustomerID, we cannot distinguish between different customers' behavior or perform any meaningful customer-level analysis.

## How to Run

### Using SQL
1. Import `online_retail.csv` into your SQL database
2. Run queries from `customer_order_analysis.sql`
3. Adjust import syntax based on your SQL system (MySQL, PostgreSQL, SQLite)

### Using Python
```bash
python analyze_customer_orders.py
```
Requires: pandas library

### Using Excel
1. Follow the step-by-step guide in `excel_analysis_guide.md`
2. Use PivotTables to analyze customer orders
3. Create visualizations as needed

## Deliverables

✅ **Customer Order Table**: Complete table with order counts per customer (CSV format)  
✅ **Top Customers Identification**: Top 10 customers by order count (CSV format)  
✅ **Customer Segmentation**: Frequency-based customer segments (5 categories)  
✅ **Geographic Analysis**: Country-wise distribution of top customers  
✅ **Interview Answers**: Comprehensive responses to both interview questions  
✅ **Multi-Tool Approach**: SQL, Python, and Excel analysis completed  
✅ **Project Report**: Comprehensive documentation with methodology and insights

## Deployment

This project uses only free resources:
- Public dataset from UCI Machine Learning Repository
- Open-source tools (SQL, Python, Excel)
- No paid services or APIs required

## Future Enhancements

- Add temporal analysis (seasonal trends)
- Calculate customer lifetime value
- Implement RFM (Recency, Frequency, Monetary) analysis
- Create data visualizations
- Add predictive modeling for customer churn


---

