"""
Task 20: Customer Order Count
Archana - Data Analytics Track
Dataset: Online Retail Dataset
Purpose: Count orders per customer and identify frequent buyers
"""

import pandas as pd
import sys

def load_data(file_path):
    """Load the online retail dataset"""
    try:
        df = pd.read_csv(file_path)
        print(f"✓ Successfully loaded dataset with {len(df)} rows")
        return df
    except Exception as e:
        print(f"✗ Error loading data: {e}")
        sys.exit(1)

def clean_data(df):
    """Remove rows with missing CustomerID or InvoiceNo"""
    original_count = len(df)
    df_clean = df.dropna(subset=['CustomerID', 'InvoiceNo'])
    df_clean = df_clean[df_clean['CustomerID'] != '']
    removed = original_count - len(df_clean)
    print(f"✓ Cleaned data: removed {removed} rows with missing CustomerID/InvoiceNo")
    return df_clean

def analyze_customer_orders(df):
    """Count orders per customer"""
    print("\n" + "="*60)
    print("CUSTOMER ORDER ANALYSIS")
    print("="*60)
    
    # Count unique orders per customer
    customer_orders = df.groupby('CustomerID').agg({
        'InvoiceNo': 'nunique',
        'InvoiceDate': ['min', 'max'],
        'Country': 'first'
    }).reset_index()
    
    customer_orders.columns = ['CustomerID', 'TotalOrders', 'FirstOrderDate', 'LastOrderDate', 'Country']
    customer_orders = customer_orders.sort_values('TotalOrders', ascending=False)
    
    return customer_orders

def display_top_customers(customer_orders, top_n=10):
    """Display top customers by order count"""
    print(f"\n📊 TOP {top_n} CUSTOMERS BY ORDER COUNT")
    print("="*60)
    print(customer_orders.head(top_n).to_string(index=False))
    
    # Save to CSV
    customer_orders.head(top_n).to_csv('top_customers.csv', index=False)
    print(f"\n✓ Saved top {top_n} customers to 'top_customers.csv'")

def calculate_summary_stats(customer_orders):
    """Calculate and display summary statistics"""
    print("\n" + "="*60)
    print("SUMMARY STATISTICS")
    print("="*60)
    
    total_customers = len(customer_orders)
    total_orders = customer_orders['TotalOrders'].sum()
    avg_orders = customer_orders['TotalOrders'].mean()
    max_orders = customer_orders['TotalOrders'].max()
    min_orders = customer_orders['TotalOrders'].min()
    
    print(f"Total Customers: {total_customers}")
    print(f"Total Orders: {total_orders}")
    print(f"Average Orders per Customer: {avg_orders:.2f}")
    print(f"Maximum Orders by Single Customer: {max_orders}")
    print(f"Minimum Orders by Single Customer: {min_orders}")

def segment_customers(customer_orders):
    """Segment customers by order frequency"""
    print("\n" + "="*60)
    print("CUSTOMER SEGMENTATION BY ORDER FREQUENCY")
    print("="*60)
    
    def get_segment(orders):
        if orders >= 50:
            return 'Very High Frequency'
        elif orders >= 20:
            return 'High Frequency'
        elif orders >= 10:
            return 'Medium Frequency'
        elif orders >= 5:
            return 'Low Frequency'
        else:
            return 'Very Low Frequency'
    
    customer_orders['FrequencySegment'] = customer_orders['TotalOrders'].apply(get_segment)
    
    segmentation = customer_orders.groupby('FrequencySegment').agg({
        'CustomerID': 'count',
        'TotalOrders': 'mean'
    }).round(2)
    
    segmentation.columns = ['CustomerCount', 'AvgOrdersInSegment']
    
    # Custom order for segments
    segment_order = ['Very High Frequency', 'High Frequency', 'Medium Frequency', 
                     'Low Frequency', 'Very Low Frequency']
    segmentation = segmentation.loc[segment_order]
    
    print(segmentation.to_string())
    
    return customer_orders

def geographic_analysis(customer_orders):
    """Analyze geographic distribution of top customers"""
    print("\n" + "="*60)
    print("GEOGRAPHIC DISTRIBUTION OF TOP CUSTOMERS (10+ orders)")
    print("="*60)
    
    top_customers = customer_orders[customer_orders['TotalOrders'] >= 10]
    geo_analysis = top_customers.groupby('Country').agg({
        'CustomerID': 'count',
        'TotalOrders': ['sum', 'mean']
    }).round(2)
    
    geo_analysis.columns = ['CustomerCount', 'TotalOrders', 'AvgOrdersPerCustomer']
    geo_analysis = geo_analysis.sort_values('TotalOrders', ascending=False)
    
    print(geo_analysis.head(10).to_string())

def save_customer_order_table(customer_orders):
    """Save complete customer order table"""
    customer_orders.to_csv('customer_order_table.csv', index=False)
    print(f"\n✓ Saved complete customer order table to 'customer_order_table.csv'")
    print(f"  Total records: {len(customer_orders)}")

def main():
    """Main execution function"""
    print("="*60)
    print("TASK 20: CUSTOMER ORDER COUNT ANALYSIS")
    print("="*60)
    
    # Load data
    df = load_data('online_retail.csv')
    
    # Clean data
    df_clean = clean_data(df)
    
    # Analyze customer orders
    customer_orders = analyze_customer_orders(df_clean)
    
    # Display results
    display_top_customers(customer_orders, top_n=10)
    calculate_summary_stats(customer_orders)
    customer_orders = segment_customers(customer_orders)
    geographic_analysis(customer_orders)
    
    # Save results
    save_customer_order_table(customer_orders)
    
    print("\n" + "="*60)
    print("✓ ANALYSIS COMPLETE")
    print("="*60)
    print("\nGenerated files:")
    print("  - top_customers.csv (Top 10 customers)")
    print("  - customer_order_table.csv (Complete customer order data)")
    print("\nInterview Question Answers:")
    print("  Q1: Customer vs order count?")
    print("  A1: See summary statistics above - relationship between customers and their orders")
    print("  Q2: Why is customer ID important?")
    print("  A2: Customer ID enables tracking individual behavior, personalization,")
    print("      and distinguishing repeat customers from one-time buyers.")

if __name__ == "__main__":
    main()
