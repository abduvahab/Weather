# Weather
weather project of school 42
# Weather App

## Introduction
This Weather App provides users with up-to-date weather information for their current location or any other specified location. With intuitive design and clear presentation, users can easily access current weather conditions, today's forecast, and a weekly overview.

## Features
1. **Search Bar and Geolocation:**
   - The app features a prominently placed search bar, allowing users to easily input their desired location.
   - Geolocation functionality is also available for quick access to the user's current location.
![alt text](https://github.com/abduvahab/Weather/blob/main/Images/searchbar.png?raw=true)
![alt text](https://github.com/abduvahab/Weather/blob/main/Images/exceptions.png?raw=true)
2. **Background Image:**
   - The background image sets the tone for the app, providing relevance without obstructing vital information. It remains fixed across all tabs for consistency.

3. **Tabs Navigation:**
   - Users can navigate between three main tabs: Current Weather, Today's Weather, and Weekly Weather.

## Current Weather Tab 
- **Displayed Information:**
  - Location: City name, region, and country.
  - Current temperature.
  - Current weather description.
  - Current weather icon.
  - Current wind speed.
- **Objective:**
  - Provide clear and concise presentation of current weather conditions.
  - Ensure information is visible at first glance, allowing users to understand within 3 seconds.
![alt text](https://github.com/abduvahab/Weather/blob/main/Images/current.png?raw=true)
## Today's Weather Tab 
- **Displayed Information:**
  - Location: City name, region, and country.
  - Temperature chart depicting hourly variations.
  - List of weather conditions throughout the day, including time, temperature, weather condition, and wind speed.
- **Specific Rules:**
  - Chart displays hours and temperature.
  - List is scrollable for easy navigation.
![alt text](https://github.com/abduvahab/Weather/blob/main/Images/current.png?raw=true)
## Weekly Weather Tab 
- **Displayed Information:**
  - Location: City name, region, and country.
  - Chart with separate curves for minimum and maximum temperatures for each day.
  - List of weather conditions for the next 7 days, including day of the week, minimum and maximum temperatures, and weather condition.
- **Specific Rules:**
  - Chart displays days of the week and corresponding min/max temperatures.
  - List is scrollable to accommodate all days of the week.
![alt text](https://github.com/abduvahab/Weather/blob/main/Images/week.png?raw=true)

## How to use
- **how to run the project:**
      -create a flutter project (flutter create project_name)
      -replace the lib directory with my lib directory
      -copy the contents of the pubspec.yaml file to your pubspec.yaml file , except the project name 
      -if you want to create app for android , replace the AndroidManifest.mal file in the path android/app/src/main
      -final step is to excute command (flutter run )
## Conclusion
This Weather App aims to provide users with a seamless experience in accessing accurate and detailed weather information. With intuitive navigation, clear presentation, and essential features like search and geolocation, users can stay informed about weather conditions wherever they are.
