# Task Manager

A web application for managing tasks and displaying local weather information.

### Requirememts
- Docker and docker compose installed.
- .env file listing the master key.
- PostgreSQL must be running locally.

### Setup
1. Clone the repository.
```
git clone git@github.com:mjnyn/task-manager.git
cd task-manager
```

2. Create `.env` file.
```
RAILS_MASTER_KEY=68c3a3a59bc9bd2246ac4c18da5d88ba
```

3. Build and start the containers.
```
  docker compose up --build
```

### Running the application
- Visit http://localhost:3000/ on your browser.
- Task page shows a list of tasks and information on current temperature on the left hand side and the sunrise and sunset on the right hand side. You may need to allow location permission for your browser for more accurate data, otherwise a default location is used.

### Running tests
```
bundle exec rspec --format documentation
```

### Notes
1. Weather **API key** is stored in rails credintials. Thus ensure you have the master key setup in your env file.
2. Weather api data is **cached** for 1 hour to reduce the number of calls made. 
3. If the browser can't find a geolocation within 5 seconds, default coordinates are used. Furthermore, if the supplied coordinates fail on the API side, default location name is used on retry.

### Troubleshooting
1. If you see `socket "/var/run/postgresql/.s.PGSQL.5432"?` related error. Ensure you have PostgreSQL running locally. You can start it using:
```
brew services start postgresql (mac)
sudo systemctl start postgresql (linux)
```