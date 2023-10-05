import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';

class customTextFormField extends StatelessWidget {
  String label;
  TextInputType keyboardtype;
  bool isPassword;
  TextEditingController controller;
  String? Function(String?) myValidator;
  customTextFormField(
      {required this.label,
      this.keyboardtype = TextInputType.text,
      this.isPassword = false,
      required this.controller,
      required this.myValidator});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            label: Text(label),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: mytheme.primarycolor, width: 2))),
        keyboardType: keyboardtype,
        obscureText: isPassword,
        validator: myValidator,
      ),
    );
  }
}
