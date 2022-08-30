import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as GeoCoding;
import 'package:provider/provider.dart';
import 'package:weather_app/config/utils.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/provider/weather-provider.dart';
import 'package:weather_app/widgets/forecast_list.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherProvider? weatherProvider;
  bool isLoading = true;
  String? imageUrl;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    weatherProvider = context.read<WeatherProvider>();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((position) {
      print('lat : ${position.latitude} lng :${position.longitude}');
      _getWeather(position);
    }).catchError((err) {
      throw err;
    });
    super.initState();
  }

  _getWeather(position) async {
    List<GeoCoding.Placemark> place = await GeoCoding.placemarkFromCoordinates(
        position.latitude, position.longitude);
    print('place is ${place[0].toJson()}');
    String? city = place[0].locality != null
        ? place[0].locality
        : place[0].administrativeArea;
    weatherProvider!.fetchLocationImage(city!.toLowerCase()).then((imageData) {
      Random random = new Random();
      int randomNumber = random.nextInt(imageData.results.length);
      print('random number is ${randomNumber}');
      print('random number is ${imageData.results.length}');

      imageUrl = imageData.results[randomNumber].urls.regular;
    });
    weatherProvider!.fetchCurrentData(position).then((value) {
      weatherProvider!.fetchForecastData(position).then((_) => {
            setState(() {
              isLoading = false;
            })
          });
    }).catchError((err) {
      throw err;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            'Weather App',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: !context.watch<ThemeProvider>().isLight
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => context.read<ThemeProvider>().changeTheme(),
              icon: Icon(
                context.watch<ThemeProvider>().isLight
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: !context.watch<ThemeProvider>().isLight
                    ? Colors.black
                    : Colors.white,
                size: 32,
              ),
            ),
            // IconButton(
            //     icon: Icon(
            //       Icons.search,
            //       color: Colors.black,
            //       size: 30.0,
            //     ),
            //     onPressed: () {
            //       showSearch(context: context, delegate: _CitySearchDelegate())
            //           .then((city) {
            //         if (city != null) {
            //           print(city);
            //           _getWeatherByCityName(city);
            //         }
            //       });
            //     })
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Opacity(
                    opacity:
                        context.watch<ThemeProvider>().isLight ? 0.45 : 0.55,
                    child: imageUrl != null
                        ? Image.network(
                            imageUrl!,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'images/weather2.jpg',
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            color: !context.watch<ThemeProvider>().isLight
                                ? Colors.blueGrey.shade800
                                : Colors.grey.shade300,
                          ),
                  ),
                  Center(
                    child: Consumer<WeatherProvider>(
                      builder: (context, providerObject, _) => Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 70,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24.0),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '${providerObject.getCurrentData.name}, ${providerObject.getCurrentData.sys.country}',
                                              style: TextStyle(
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Icon(Icons.location_pin),
                                          ),
                                        ]),
                                  ),
                                  Text(
                                    getFormattedDate(
                                        providerObject.getCurrentData.dt,
                                        'EEE, MMM dd, yyyy'),
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '${providerObject.getCurrentData.main.temp.round()}\u00B0C',
                                    style: TextStyle(
                                        fontSize: 64.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 240,
                                  ),
                                  Text(
                                    'Humidity ${providerObject.getCurrentData.main.humidity}',
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image.network(
                                        '$WEATHER_ICON_PREFIX${providerObject.getCurrentData.weather[0].icon}$WEATHER_ICON_SUFFIX',
                                        height: 61.0,
                                        width: 61.0,
                                        fit: BoxFit.cover,
                                        color: !context
                                                .watch<ThemeProvider>()
                                                .isLight
                                            ? Colors.blueGrey.shade800
                                            : Colors.grey.shade300,
                                      ),
                                      Text(
                                        '${providerObject.getCurrentData.weather[0].main}',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Sunrise : ${getFormattedDate(providerObject.getCurrentData.sys.sunrise, 'hh:mm a')} | Sunset ${getFormattedDate(providerObject.getCurrentData.sys.sunset, 'hh:mm a')}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Weather By 3 hourly',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .25,
                              child: ListView.builder(
                                  padding: EdgeInsets.all(8.0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: providerObject
                                      .getforecastData.list.length,
                                  itemBuilder: (context, index) => ForecastList(
                                      forecastElement: providerObject
                                          .getforecastData.list[index])),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }

  void _getWeatherByCityName(String city) {
    GeoCoding.locationFromAddress(city).then((locationList) {
      if (locationList.isNotEmpty && locationList.length > 0) {
        double lat = locationList.first.latitude;
        double lng = locationList.first.longitude;
        final position = Position(
            longitude: lng,
            latitude: lat,
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
            isMocked: false,
            timestamp: locationList.first.timestamp);
        _getWeather(position);
      }
    }).catchError((error) {
      throw error;
    });
  }
}

class _CitySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListTile(
      onTap: () {
        close(context, query);
      },
      title: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var filteredList = query == null
        ? cities
        : cities
            .where((city) => city.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = filteredList[index];
        },
        title: Text(filteredList[index]),
      ),
      itemCount: filteredList.length,
    );
  }
}
