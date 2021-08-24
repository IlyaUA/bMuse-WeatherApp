# bMuse-WeatherApp

### Task Description 
Write an application that displays a weather forecast  Fetch the forecast by using this API:<https://api.met.no/doc/GettingStarted> ,<https://api.met.no/doc/ForecastJSON> , parse and display the results in a table form in two tabs: “Hourly” for the next 24 hours with one cell per hour, and “Daily” for the next week with one cell per day. Each cell should contain a time, an air temperature, a wind speed and a weather condition icon for the time interval till the next entry ( next_1_hours  for hourly forecast and the max available hours for the weekly one). In the footer display the time when the weather provider updated their weather information, see JSON “meta” node. Display only the current and future entries, don’t show forecast for the past time. Please leave comments in code where appropriate.  Any additional extra features are welcome, like allowing to pick a location on a map (use Apple Maps) to get weather information for that location, error handling, friendly UI, saving data to support offline mode and so on.

### Additional tasks
Added offline mod
Ability to select a location on the map (Apple Maps) by long press
Determining a city by coordinates using CoreLocation

# Result

<p align="center">
  <img width="32%" height="32%" src="https://github.com/IlyaUA/bMuse-WeatherApp/blob/main/Screenshots/Main.png?raw=true">
  <img width="32%" height="32%" src="https://github.com/IlyaUA/bMuse-WeatherApp/blob/main/Screenshots/Map.png?raw=true">

</p>
