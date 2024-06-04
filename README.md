# Openclass

## Prerequisites
 - Python 3.12 or higher
 - Node.js
 - SQLite 3
   - Download sqlite from https://sqlite.org/2024/sqlite-dll-win-x64-3460000.zip

## Production
 - Run the script ```run.bat``` for windows or ```run.sh``` for linux
<!--  -->
## Development
 - CD into the server folder ```cd server```
 - Install python requirements with ```pip install -r requirements.txt```
 - Run the server with ```flask --app server run --debug```

 - CD into the client folder ```cd openclass```
 - Install node modules with ```npm install```
 - Run the client with ```npm run dev -- --open```