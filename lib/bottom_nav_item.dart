import 'package:flutter/material.dart';

class bottom_nav_item extends BottomNavigationBarItem{
  String label;
  bottom_nav_item({required this.label, required super.icon});

  BottomNavigationBarItem build() {
    return BottomNavigationBarItem(
        icon: icon,
        label: label
    );
  }
}
