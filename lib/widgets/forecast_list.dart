import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/utils.dart';
import 'package:weather_app/data/constants/constants.dart';
import 'package:weather_app/models/forecast-weather-model.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/utils/time_utils.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widgets/main_widgets.dart';

class ForecastList extends StatelessWidget {
  final ForecastElement? forecastElement;

  const ForecastList({Key? key, this.forecastElement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      // margin: const EdgeInsets.all(6.0),
      // padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: context.watch<ThemeProvider>().isLight
            ? Colors.blueGrey.shade800
            : Colors.grey.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      constraints: const BoxConstraints(
        minWidth: 110,
        minHeight: 140,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      margin: EdgeInsets.all(8.0),
      // decoration: BoxDecoration(
      //     color: context.watch<ThemeProvider>().isLight
      //         ? Colors.blueGrey.shade800
      //         : Colors.grey.shade300,
      //     borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            getFormattedDate(forecastElement!.dt, 'EEE'),
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
          ),
          Text(
            getFormattedDate(forecastElement!.dt, 'h a'),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: buildWeatherIcon(
                '$WEATHER_ICON_PREFIX${forecastElement!.weather[0].icon}$WEATHER_ICON_SUFFIX'),
          ),
          // Expanded(
          //   child: Image.network(
          //     '$WEATHER_ICON_PREFIX${forecastElement!.weather[0].icon}$WEATHER_ICON_SUFFIX',
          //     height: 100.0,
          //     width: 100.0,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          buildTempText(
            context: context,
            temp: forecastElement!.main.tempMax,
          ),
        ],
      ),
    );
  }
}

Widget buildDayOrHourlyView({
  required BuildContext context,
  required int viewIndex,
  required List<Hourly> weatherHourly,
  required List<Daily> weatherByDay,
}) {
  switch (viewIndex) {
    case 0:
      return weatherHourly.isEmpty
          ? const Offstage()
          : _buildWeatherView(
              context: context,
              header: Constants.hourlyWeather,
              children: weatherHourly
                  .map((e) => _buildWeatherItem(
                        context: context,
                        head: getTimeHour(e.dt),
                        temp: e.temp,
                        icon: e.weather?[0].icon,
                        weather: e.weather?[0].main ?? '',
                      ))
                  .toList(),
            );
    case 1:
      return weatherByDay.isEmpty
          ? const Offstage()
          : _buildWeatherView(
              context: context,
              header: Constants.weatherByDay,
              children: weatherByDay
                  .map((e) => _buildWeatherItem(
                        context: context,
                        head: getDayAndMonth(e.dt),
                        temp: e.temp?.day,
                        icon: e.weather?[0].icon,
                        weather: e.weather?[0].main ?? '',
                      ))
                  .toList(),
            );
    default:
      return const Offstage();
  }
}

Widget _buildWeatherView({
  required BuildContext context,
  required String header,
  required List<Widget> children,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 42.0, left: 16.0, bottom: 12.0),
        child: Text(
          header,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: children,
          ),
        ),
      ),
    ],
  );
}

Widget _buildWeatherItem({
  required BuildContext context,
  required String head,
  required double? temp,
  required String? icon,
  required String weather,
}) {
  return Container(
    clipBehavior: Clip.hardEdge,
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    ),
    constraints: const BoxConstraints(
      minWidth: 110,
      minHeight: 150,
    ),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            head,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        buildTempText(
          context: context,
          temp: temp,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: buildWeatherIcon(icon),
        ),
        Text(
          weather.toLowerCase(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    ),
  );
}
