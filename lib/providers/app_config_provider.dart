import 'package:flutter/material.dart';

class appConfigProvider extends ChangeNotifier {
String appLanguage='en';
ThemeMode appTheme=ThemeMode.dark;
void changeLanguage(String newLanguage){
  if(appLanguage==newLanguage){return;}
  else{appLanguage=newLanguage;
  notifyListeners();}
}
void changeTheme(ThemeMode newMode){
  if(appTheme == newMode){
    return;
  }
  appTheme = newMode ;
  notifyListeners();
}

bool isDarkMode(){
  return appTheme == ThemeMode.dark;
}
}

