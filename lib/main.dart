import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/locator.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/provider/weather-provider.dart';
import 'package:weather_app/screens/home-page.dart';
import 'package:weather_app/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
    ),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: context.watch<ThemeProvider>().theme,
      home: SplashScreen(),
    );
  }
}
