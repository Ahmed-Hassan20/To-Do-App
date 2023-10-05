import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils/firebase_utils.dart';
import 'package:todo/providers/auth_provider.dart';

import '../model/task.dart';

class appConfigProvider extends ChangeNotifier {
  List<task> tasklist = [];
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.dark;
  DateTime selectedDate = DateTime.now();
  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    } else {
      appLanguage = newLanguage;
      notifyListeners();
    }
  }

  void changeTheme(ThemeMode newMode) {
    if (appTheme == newMode) {
      return;
    }
    appTheme = newMode;
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }

  bool isDone(task Task) {
    if (Task.isDone == true) {
      return true;
    }
    return false;
  }

  void getAlltasksFromForestore(String uId) async {
    QuerySnapshot<task> querySnapshot =
        await firebaseutils.getTaskCollection( uId).get();
    tasklist = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    // tasklist = tasklist.where((task) {
    //   if (task.dateTime?.day == selectedDate.day &&
    //       task.dateTime?.month == selectedDate.month &&
    //       task.dateTime?.year == selectedDate.year) {
    //     return true;
    //   }
    //   return false;
    // }).toList();

    tasklist.sort((task Task1, task Task2) {
      return Task1.dateTime!.compareTo(Task2.dateTime!);
    });
    notifyListeners();
  }

  void setNewSelDate(DateTime newDate,String uId) {
    selectedDate = newDate;
    getAlltasksFromForestore(uId);
  }

}
