import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils/firebase_utils.dart';
import 'package:todo/model/task.dart';
import 'package:todo/my_theme.dart';

import '../providers/app_config_provider.dart';

class addtaskbottomsheet extends StatefulWidget {
  const addtaskbottomsheet({super.key});

  @override
  State<addtaskbottomsheet> createState() => _addtaskbottomsheetState();
}

class _addtaskbottomsheetState extends State<addtaskbottomsheet> {
  DateTime selectedDate = DateTime.now();
  var formkey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late appConfigProvider listprovider;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appConfigProvider>(context);
    listprovider = Provider.of<appConfigProvider>(context);
    return Container(
      color: provider.isDarkMode() ? mytheme.darkblack : mytheme.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.add_new_task,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: provider.isDarkMode() ? mytheme.white : mytheme.black),
          ),
          SizedBox(
            height: 6,
          ),
          Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please Enter Task Title';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      title = text;
                    },
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enter_title,
                        hintStyle: TextStyle(
                            color: provider.isDarkMode()
                                ? mytheme.grey
                                : mytheme.black),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                  TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please Enter Task datails';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      description = text;
                    },
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enter_details,
                        hintStyle: TextStyle(
                            color: provider.isDarkMode()
                                ? mytheme.grey
                                : mytheme.black),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    maxLines: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.select_date,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: provider.isDarkMode()
                              ? mytheme.grey
                              : mytheme.black),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showcalendar();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: provider.isDarkMode()
                                ? mytheme.grey
                                : mytheme.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addtask();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.add,
                        style: Theme.of(context).textTheme.titleLarge,
                      ))
                ],
              ))
        ],
      ),
    );
  }

  void showcalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }

  void addtask() {
    if (formkey.currentState?.validate() == true) {
      task Task =
          task(title: title, description: description, dateTime: selectedDate);
      firebaseutils.addtasktofirebase(Task).timeout(Duration(milliseconds: 500),
          onTimeout: () {
        print('passed**********');

        listprovider.getAlltasksFromForestore();
        Navigator.pop(context);
      });
    }
  }
}
