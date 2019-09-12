## weather-explorer
 
iOS App to search the weather by entering the name of area-name/region/country.
> Uses MVVM architecture with reactive approach (no use of external libraries).

### Getting Started

Download/Clone [Weather Explorer](https://github.com/buntylm/weather-explorer.git) and open weather.xcodeproject.

### Prerequisites

Things you need to install first.

```
Xcode 10
Swift 4.2.
iOS SDK 11.
```

### Features

- [x] Search Weather by area-name/region/country.
- [x] Tap on search result to presist locally.


### Architecture 

    ├─ Search City Flow

![Search Location Flow](https://github.com/buntylm/weather-explorer/blob/master/SearchLocationFlow.png)


### Project Structure

    ├─ Models
    ├─ Views
    ├─ ViewModels
    ├─ Stores
    ├─ Helpers
    ├─ Resources
    
### What's next
> Few things that we can consider.

- Image caching.
- Increase testing scope by giving different input values.
- HTTP request throttling.
- Intergate logger to print the logs.
- Localisation and images assets handling using Swift gen.xml
- Internet Connection Handling.

### Source code coverage
![Code coverage](https://github.com/buntylm/weather-explorer/blob/master/code-coverage.png)


### Author
Bunty Madan – [@buntylm](https://stackoverflow.com/users/1603380/buntylm) – https://bmnotes.com

### License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
