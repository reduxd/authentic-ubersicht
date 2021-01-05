# Authentic Weather
The most honest weather app, on your desktop

![widget 1](http://puu.sh/gd602/667b2a8758.png)
![widget 4](http://puu.sh/gd63H/50ef4e972b.png)

## Installation
1. Download [Übersicht](http://tracesof.net/uebersicht/)
2. Copy `authentic.widget` to your widgets folder.
3. Add your [OpenWeatherMap API key](https://openweathermap.org/api) to `authentic.coffee`.

## Advanced

### Setting the Units
Celsius and Fahrenheit units are provided in the widget. To adjust this, change the value of `unit` in `authentic.coffee`.

### Setting the Icon Set
Three icon sets are provided with the widget: white, black, and blue. To adjust this, change the value of `icon` in `authentic.coffee`.

### Setting the Snippet
The widget above the phrase can be changed between an icon, the temperature, or both. To adjust this, change the value of `showIcon` and `showTemp` in `authentic.coffee`.

### Setting the Refresh Rate
By default, the widget will get new data every 5 minutes. To adjust this, change the value of `rate` in `authentic.coffee`. The value should be in milliseconds, so multiply the number of seconds by 1000. Note that forecast.io has a limit on how frequently you can send requests.

## Changelog

### 10/06/20
- Compatible with OpenWeatherMap API

### 03/17/15
- Now requires Ubersicht v0.5 or higher
- Uses new geolocation API instead of manual lat/lon coordinates

## Credits
Idea, graphics, and phrases are from [Authentic Weather](https://authenticweather.com). Most resources have been dumped from the Android app in order to resemble it as closely as possible.
