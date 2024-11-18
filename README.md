This is my very first dashboard project!

First, I used the QuickDBD tools to easily design all the tables that I needed for the project.
Then, I created a database on MySQL Workbench and executed the code to create tables

Errors - Import data into tables
At first, I tried to import data on MySQL Workbench, but it didn't work. Even when I converted a CSV file to a JSON file, I got nothing. Then, I tried to import data on Navicat. It ran well until table Orders and Rotations were finished with errors (I think it's because those files have date and time values).
So, I copied the data to Google Sheets and downloaded the CSV files. Then, I tried to import data again on MySQL Workbench and it ran successfully.

Connect Tableau with MySQL Workbench
- Following Tableau support https://www.tableau.com/support/drivers
I installed the iODBC Driver Manager and the MySQL ODBC Connector for MacOS, but I still got the Error Code: B19090E0.
- I tried to check the MySQL connection, Firewall, and user permissions but it didn't work.
- After 2 days of researching this error, I tried to install an older version of MySQL ODBC Connector and restarted all the tools. Now it works great for me.



I'm going to build the Order activity, with the following data:
1. Total orders = COUNTD(Order_Id)
2. Total sales = Item_price * Quantity
3. Total items = SUM(quantity)
4. Average order value = SUM(total sales) / COUNTD(Order_Id)
5. Sales by category (doughnut chart)
6. Top-selling items (bar chart)
7. Orders by hour (line chart)
8. Sales by hour (line chart)
9. Orders by address (map)
10. Orders by delivery/pick up

![Result  Order Activity](https://github.com/user-attachments/assets/c7e84238-4e1f-438a-9d32-51e3284723bd)








