// To parse this JSON data, do
//
//     final forecastWeatherResponse = forecastWeatherResponseFromJson(jsonString);

import 'dart:convert';

ForecastWeatherResponse forecastWeatherResponseFromJson(String str) =>
    ForecastWeatherResponse.fromJson(json.decode(str));

String forecastWeatherResponseToJson(ForecastWeatherResponse data) =>
    json.encode(data.toJson());

class ForecastWeatherResponse {
  ForecastWeatherResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  String cod;
  int message;
  int cnt;
  List<ForecastElement> list;
  City city;

  factory ForecastWeatherResponse.fromJson(Map<String, dynamic> json) =>
      ForecastWeatherResponse(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<ForecastElement>.from(
            json["list"].map((x) => ForecastElement.fromJson(x))),
        city: City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "city": city.toJson(),
      };
}

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  int id;
  String name;
  Coord coord;
  String country;
  int? population;
  int timezone;
  int sunrise;
  int sunset;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });

  double lat;
  double lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class ForecastElement {
  ForecastElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    this.rain,
    required this.sys,
    required this.dtTxt,
  });

  int dt;
  MainClass main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Rain? rain;
  Sys sys;
  DateTime dtTxt;

  factory ForecastElement.fromJson(Map<String, dynamic> json) =>
      ForecastElement(
        dt: json["dt"],
        main: MainClass.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"].toDouble(),
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
        sys: Sys.fromJson(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds.toJson(),
        "wind": wind.toJson(),
        "visibility": visibility,
        "pop": pop,
        "rain": rain == null ? null : rain!.toJson(),
        "sys": sys.toJson(),
        "dt_txt": dtTxt.toIso8601String(),
      };
}

class Clouds {
  Clouds({
    this.all,
  });

  int? all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

class MainClass {
  MainClass({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
      };
}

class Rain {
  Rain({
    this.the3H,
  });

  double? the3H;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the3H: json["3h"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "3h": the3H,
      };
}

class Sys {
  Sys({
    this.pod,
  });

  Pod? pod;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: podValues.map![json["pod"]],
      );

  Map<String, dynamic> toJson() => {
        "pod": podValues.reverse[pod],
      };
}

enum Pod { D, N }

final podValues = EnumValues({"d": Pod.D, "n": Pod.N});

class Weather {
  Weather({
    required this.id,
    this.main,
    required this.description,
    required this.icon,
  });

  int id;
  MainEnum? main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: mainEnumValues.map![json["main"]],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainEnumValues.reverse[main],
        "description": description,
        "icon": icon,
      };
}

enum MainEnum { RAIN, CLOUDS }

final mainEnumValues =
    EnumValues({"Clouds": MainEnum.CLOUDS, "Rain": MainEnum.RAIN});

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  double speed;
  int deg;
  double gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
        gust: json["gust"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}