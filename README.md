# Event-api

Event-api is a system that provides an API for recording various events such as concerts, charity games, pallets, sporting events.The following describes data modeling and instructions for use.

## Data model
<img src="https://raw.githubusercontent.com/MaxAlmeida/events-api/master/event-api-diagram.jpg">
Event-api data modeling is based on the following context:

 * A user can comment on an event.
 
 * you can report a message only once.
 
 * An event can receive multiple comments.
 
 * A comment may receive multiple reports
 
 * An instance of a report is associated with a single user and a single message.
 
 * A message instance is associated with a single user and a single event.
 
 
## Enviroment
 Configure your system with the following versions:
 
 * Ruby version: 2.3.3
  
 * Rails version: 5.2
  
 * Database configuration and gems installation:
    * Install gems
      ```
        $ bundle install
      ```
      
    * Modify username and password in config/database.yml according to your database settings:
    
      ```
        default: &default
        adapter: mysql2
        encoding: utf8
        pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
        timeout: 5000
        username: user_your_database
        password: root_your_database
      ```
    * Create database:
      ```
       $ rake db:create
      ```
      ```
       $ rake db:migrate
      ```
    * Initialize database:
      ```
       $ rake db:seed
      ```
    * Finally, run the following in order start server:
    
       ```
       $ rails s

       ```    
  * Running tests:
    ```
      $ rspec
    ```
    
## API Usage
The following table show routes provided by this api:

HTTP Verb | Path | Controller#Action | Used for
--------- | ---- | ----------------- | -------
GET | /api/v1/events/:event_id/comments |  api/v1/comments#index | show all comments for a specific event
POST |  /api/v1/events/:event_id/comments | api/v1/comments#create | create a new comment in specific event
GET | /api/v1/events/:event_id/comments/:id | api/v1/comments#show | display a specific comment in specific event
PATCH/PUT | /api/v1/events/:event_id/comments/:id | api/v1/comments#update | update a specific comment in specific event
DELETE | /api/v1/events/:event_id/comments/:id | api/v1/comments#destroy | delete a specific comment in specific event
GET | /api/v1/events/:event_id/reports | api/v1/comments#reports | show all comments reported for a specific event (**Bonus!!**)
GET | /api/v1/events | api/v1/events#index | show all events
POST | /api/v1/events | api/v1/events#create | create a new event
GET | /api/v1/events/:id | api/v1/events#show | show a specific event
PATCH/PUT | /api/v1/events/:id | api/v1/events#update | update a specific comment
DELETE | /api/v1/events/:id | api/v1/events#destroy | destroy a specific event
POST  | /api/v1/reports | api/v1/reports#create | create a new report
POST | /api/v1/signup | api/v1/users#create | create a new user



