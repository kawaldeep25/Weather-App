import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool isLight = true;
  final ThemeData _dark = ThemeData(
    colorScheme:
        const ColorScheme.dark(secondary: Colors.amber, primary: Colors.amber),
  );
  final ThemeData _light = ThemeData(
    colorScheme: const ColorScheme.light(
        secondary: Colors.teal,
        onSecondary: Colors.white,
        primary: Colors.teal),
  );

  ThemeData get theme => isLight ? _dark : _light;

  changeTheme() {
    isLight = !isLight;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('theme', isLight.toString()));
  }
}
