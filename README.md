# Money Dashboard Budgeting Web App

## Overview

A budgeting app to help the user see where all of their money is being spent.

User can:
* Create new transactions (with date, merchant and 'tag')
* Add new merchants or tags if not already available in dropdown menu when creating a new transaction
* View all transactions recorded
* View a breakdown of total spend in £  and % terms by month, merchant or tag
* View all transactions for a particular month, merchant or tag
* Set a budget (and see an alert message if total spend is over budget)

App is written in Ruby and uses the web application framework Sinatra.

Note that this web app has been designed to be viewed using Google Chrome and some items may display strangely in other browsers.

## Screenshots

### Homepage

![Screenshot](https://github.com/rach-j/money-dashboard-budgeting-web-app/blob/master/screenshots_for_README/Screenshot-homepage-1.png)

![Screenshot](https://github.com/rach-j/money-dashboard-budgeting-web-app/blob/master/screenshots_for_README/Screenshot-homepage-2.png)

### Add new transaction page
![Screenshot](https://github.com/rach-j/money-dashboard-budgeting-web-app/blob/master/screenshots_for_README/Screenshot-add-new-transaction.png)

### View spend breakdown by tag page
![Screenshot](https://github.com/rach-j/money-dashboard-budgeting-web-app/blob/master/screenshots_for_README/Screenshot-view-breakdown-by-tag.png)

### View all transactions for the 'Clothing' tag page
![Screenshot](https://github.com/rach-j/money-dashboard-budgeting-web-app/blob/master/screenshots_for_README/Screenshot-view-all-transactions-for-particular-tag.png)


## To run

### Prerequisites

* Ruby
* PostgreSQL

These can be downloaded online. Installation depends on your operating system but there are plenty of resources online that explain how to do this.

### To run

* Install bundler: `$ gem install bundler`
* Download this project (this can be done using the command `$git clone https://github.com/rach-j/money-dashboard-budgeting-web-app.git`)
* Install project gems: `$ bundler install`
* Create a database: `$ createdb spending`
* Set up tables in the database: `$ psql -d spending -f db/spending.sql`
* Seed database with some data: `$ ruby db/seeds.rb`
* Run app: `$ ruby app.rb`
