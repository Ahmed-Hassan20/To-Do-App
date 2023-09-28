import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_utils/firebase_utils.dart';

import '../model/task.dart';

class appConfigProvider extends ChangeNotifier {

  List<task> tasklist=[];
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

  void getAlltasksFromForestore() async {
    QuerySnapshot<task> querySnapshot=await firebaseutils.getTaskCollection().get();
    tasklist= querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
   notifyListeners();
  }

}

