# Business Challenge
# Exploratory Data Analysis, mySQL Databases and SQL Queries

## Introduction

This business challenge takes a car dataset of recorded sales in the USA from december of 2014 to july 2015. Vehicules's production year range from 1990 to 2015.
The goal is to pick a business case, perform Exploratory Data Analysis (EDA) and prepare the data for a mySQL Database using python, Create a new SQL db, inject the data and perform SQL queries to answer 10 questions related to our business case.

## Business case and context

Our brand new company is looking to enter the car selling market and knows nothing about it.

Scope of analysis : General.
Goal : Gain insight on broad data to determine what sub niche of the car market our company should focus on.

We want to know : How big is the market, who is the biggest player, nº of cars sold per month, most sold category, automatic vs manual…


## EDA

This dataset provides a comprehensive collection of information pertaining to the sale transactions of various vehicles (data from december of 2014 to july 2015), new and used, production year ranging from 1990 to 2015.

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/dd373b96-16e7-497c-b5e4-1d7eb3f02eb2)

  ### Data cleaning in python

- Deleted the column MMR as it is not relevant for our analysis.
- Deleted the trim column as it is not relevant since we are conducting a general analysis on the cars market.
- Cleaned the sale date column to obtain only the day, month and year in SQL preferred format.
- Eliminated every row where at least one column has a null value, that way we are working with a dataset without null values :).

  ### mySQL preparation

I divided the dataset into 3 csv files to have 3 tables in SQL.
Those 3 tables are linked by a key like so :

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/5e4f229e-aa8d-412d-a840-d909289b5d33)

The schema and tables creation was done through SQL code/queries.
Changed the permissions inside the my.ini file of the SQL server to allow data import from a local csv file with queries.

At last i queried the import from the csv files, filled my tables and verified if the import was done correctly.


## Answering 10 business questions with SQL queries

0 - Show amount of cars sold per month 

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/40213b32-dda9-493f-ba51-ffcf4b8578c9)

1 - Which car brand sold the most vehicles in 2015 

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/b34293eb-0b80-40a3-8048-be14d2aa0323)

2 - Which vehicle model is the most sold overall models across all brands

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/ce8dbf04-b632-49ea-abb1-fbd4513b0ab4)

3 - What category of vehicle is the most sold 

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/ac3862bc-0e3b-466b-a515-642ec7ac1f0c)

4 - What percentage of the sales do all types of vehicle encompass 

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/2602a612-9906-47db-bffb-c119f4de3303)

5 - Most popular colour for toyota cars 

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/6acf2a90-57e4-440e-9947-160c2ea46fe2)

6 - How many manuals and how many automatics are in the database sorted by each year of production (not sold)?

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/2d776278-a00d-4765-9e02-0911e63a6364)

7 - Average odometer of a car when sold

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/f14358a9-5261-4b6b-8235-f45b184706f0)

8 - Most popular interiors ? 

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/feb9e321-7349-47f5-abe4-8c783c970b71)

9 - Which seller has the highest total sales in $ ?

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/8c26c239-9179-48c8-9559-9125efb183fc)

10 - Rank sellers by the amount of cars they sold in total descending 

![image](https://github.com/alxndrfly/mySQL-Project/assets/135460292/32e9a2d3-8292-4ca7-af19-1e3f16a61b89)

