# Excel Analysis Guide for Customer Order Count

## Setup Instructions

### Step 1: Open the Dataset in Excel
1. Open Microsoft Excel
2. Open `online_retail.csv` (File > Open > Select the CSV file)
3. Excel will automatically detect the columns

### Step 2: Clean the Data
1. Create a new sheet called "Clean_Data"
2. Filter the original data:
   - Click on the headers
   - Filter column "CustomerID" to remove blanks
   - Filter column "InvoiceNo" to remove blanks
3. Copy the filtered data to the "Clean_Data" sheet

### Step 3: Create Customer Order Count Table
1. Go to "Clean_Data" sheet
2. Select the entire dataset (CustomerID and InvoiceNo columns)
3. Go to Insert > PivotTable
4. Choose "New Worksheet" and click OK
5. In the PivotTable Fields pane:
   - Drag "CustomerID" to ROWS
   - Drag "InvoiceNo" to VALUES
   - Change the value calculation to "Distinct Count" (Value Field Settings > Distinct Count)
6. Rename the worksheet to "Customer_Order_Count"
7. Sort by Count of InvoiceNo in descending order
8. Save this as `customer_order_table.xlsx`

### Step 4: Identify Top Customers
1. In the "Customer_Order_Count" sheet
2. The top 10 customers are already visible at the top
3. Copy the top 10 rows to a new sheet called "Top_Customers"
4. Add column headers: CustomerID, OrderCount
5. Save this as `top_customers.xlsx`

### Step 5: Create Summary Statistics
Create a new sheet "Summary" with these formulas:

```
Total Customers:  =COUNTA(A:A)-1  (assuming CustomerID in column A)
Total Orders:     =SUM(B:B)       (assuming OrderCount in column B)
Average Orders:   =AVERAGE(B:B)
Max Orders:       =MAX(B:B)
Min Orders:       =MIN(B:B)
```

### Step 6: Customer Segmentation
1. In the "Customer_Order_Count" sheet
2. Add a new column "Segment" next to OrderCount
3. Use this formula (assuming OrderCount is in column B):
   ```
   =IF(B2>=50,"Very High Frequency",IF(B2>=20,"High Frequency",IF(B2>=10,"Medium Frequency",IF(B2>=5,"Low Frequency","Very Low Frequency"))))
   ```
4. Drag the formula down
5. Create a PivotTable to count customers per segment

### Step 7: Geographic Analysis
1. Go back to "Clean_Data" sheet
2. Create a PivotTable with:
   - CustomerID in ROWS
   - Country in COLUMNS
   - InvoiceNo in VALUES (Distinct Count)
3. Filter for customers with 10+ orders

## Interview Question Answers

### Q1: Customer vs order count?
**Answer:** 
- Total Customers: [Count from your data]
- Total Orders: [Sum from your data]
- Average Orders per Customer: [Average from your data]
- This shows the distribution of orders across customers

### Q2: Why is customer ID important?
**Answer:**
Customer ID is crucial because:
- It uniquely identifies each customer across multiple transactions
- Enables tracking of repeat purchases vs one-time buyers
- Allows for customer segmentation and personalization
- Essential for loyalty programs and targeted marketing
- Without CustomerID, we cannot distinguish between different customers' behavior

## Alternative: Using Power Query in Excel

For more advanced analysis:
1. Data > Get Data > From File > From CSV
2. Select `online_retail.csv`
3. In Power Query Editor:
   - Filter out null CustomerID values
   - Group by CustomerID and count distinct InvoiceNo
   - Add custom columns for segmentation
4. Load to Excel as a table
