This is a DA porfollio project about a pizza store

First, I used the QuickDBD tools to easily design all the tables that I need for the project.
Then, I created a database on MySQL Workbench and executed the code to create tables

Errors - Import data into tables
At first, I tried to import data on MySQL Workbench, but it didn't work. Even when I converted a CSV file to a JSON file, I got nothing. Then, I tried to import data on Navicat. It ran well until table Orders and Rotations were finished with errors (I think it's because those files have date and time values).
So, I copied the data to Google Sheets and downloaded the CSV files. Then, I tried to import data again on MySQL Workbench and it ran successfully.



I'm going to build:

Dashboard 1 - Order activity, which following data:
1. Total orders
2. Total sales
3. Total items
4. Average order value
5. Sales by category
6. Top selling items
7. Orders by hour
8. Sales by hour
9. Orders by address
10. Orders by delivery/pick up

Dashboard 2 - Inventory Management
1. Total quantity by ingredient (we need to know how many ordered and what is the recipe/ingredients we need for each pizza)
2. Total cost of ingredients
3. Calculated cost of pizza
4. Percentage stock remaining by ingredient
