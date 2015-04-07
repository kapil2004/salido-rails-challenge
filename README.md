## Ruby, Rails, Postgres

This app was developed using Ruby 2.1.5 and Rails 4.2.1.  It uses PostgreSQL for database in development and test environments.  

## How to run the test suite

There are a few integration tests for the API portion of this app.  They can be run with the following command: rspec spec

## Setup

1. Install postgres if it is not already installed.  Make sure it is running.
1. Run bundle to install all the necessary dependencies.
1. The database.yml file assumes the database is accessible for the default user.  No username or password is specified in the database.yml file.
1. Run rake db:create, rake db:migrate to run the migrations.

## Downloading Wine.com catalog

1. Run rake salido:get_wine_catalog to download wine.com's wine catalog.  

## API Calls

The following two API calls are available:

### To get a list of wines:

get '/api/wines' returns a list of at most 10 wines.  
The following parameters can be supplied:
- limit : The default value for limit is 10.  To get N wines in the list, provide parameter 'limit=N'.
- offset : The default offset is 0.
- filter : To filter by wine name, provide the filter parameter.  It performs a LIKE match for wine name with the supplied value.

Example: curl http://localhost:3000/api/wines?limit=3
         curl http://localhost:3000/api/wines?filter=Pinot

### To update a wine:

patch '/api/wines/:id'

This request takes a JSON string in request body to update a wine.  The attributes that can be updated are limited via the wine_params method in api/wines_controller.rb file.

Example: curl -X PATCH -d 'wine[name]=New Wine Name' http://localhost:3000/api/wines/1  updates the name of wine with id = 1 to 'New Wine Name'












