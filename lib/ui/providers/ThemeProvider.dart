import 'package:evently_app/ui/common/AppSharedPreferences.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  late ThemeMode _themeMode;
  AppSharedPreferences appSettingsPreferences = AppSharedPreferences.getInstance();
  ThemeProvider(){
    _themeMode = appSettingsPreferences.getCurrentTheme();
  }

  List<ThemeMode> getModes(){
    return [
      ThemeMode.light,
      ThemeMode.dark,
    ];
  }
  ThemeMode getSelectedThemeMode(){
    return _themeMode;
  }
  void changeTheme(ThemeMode newMode){
    _themeMode = newMode;
    appSettingsPreferences.saveTheme(_themeMode);
    notifyListeners();
  }
}