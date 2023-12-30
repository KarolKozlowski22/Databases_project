# Airports Database Project

This project is a part of the Database Systems course and serves as a final project for assessment. Due to specific requirements, the application intentionally avoids utilizing the full potential of Flask and SQLAlchemy. Instead, database operations are handled using raw SQL queries.

## Overview

The Airports Database Project focuses on managing and displaying information related to airports, flights, passengers, employees, and more. It is a web application that provides insights into various aspects of examplary database management.

## Technologies Used

- Docker: The entire web application is containerized for easy deployment and management.
- Flask: Used for building the web application and handling routing.
- SQLAlchemy: Although not fully utilized, it plays a role in connecting the application with the database.
- Raw SQL Queries: The primary method for interacting with the database, as per the project requirements.

## Features

- **List of Airports:** View a list of airports, including details such as name, city, airport code, and country.

- **Arrivals and Departures:** Retrieve information about arrivals and departures on a specific date using raw SQL queries.

- **Passenger Count:** Obtain the total number of passengers at each airport.

- **Most Frequently Used Aircraft:** Find the top five most frequently used aircraft departing from a specified airport.

- **Employees at the Airport:** Retrieve a list of employees working at a particular airport.

## Getting Started

### Prerequisites

- Docker installed on your machine.

### Running the Application

1. Clone this repository to your local machine.

   git clone https://github.com/KarolKozlowski22/Databases_project

2. Enter folder and run docker-compose.

   cd Databases_project && docker-compose up --build

3. Enter pgadmin container under localhost:5050 and log in with the following credentials:

    - Email: admin@admin.com
    - Password: admin

4. Create a new server with the following credentials:
    
    - Host name/address: postgres
    - Port: 5432
    - Username: root
    - Password: root

    You can also find Host address by running `docker inspect postgres` and looking for the "IPAddress" field. Linux: 'docker inspect postgres | grep IPAddress', Windows: 'docker inspect postgres | findstr IPAddress'.

5. Now you can run the application under localhost:5000/main.

### Contact
email: kozlowskikarol02@gmail.com

