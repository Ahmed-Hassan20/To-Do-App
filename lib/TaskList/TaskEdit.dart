import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/app_config_provider.dart';

class taskedit extends StatefulWidget {
  static const String routename = "taskedit";
  @override
  State<taskedit> createState() => _taskeditState();
}

class _taskeditState extends State<taskedit> {
  DateTime selectedDate = DateTime.now();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: provider.isDarkMode() ? mytheme.black : mytheme.white,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.23,
              top: MediaQuery.of(context).size.height * 0.05,
              right: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.height * 0.02),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: provider.isDarkMode() ? mytheme.darkblack : mytheme.white),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.edit_task,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color:
                          provider.isDarkMode() ? mytheme.white : mytheme.black,
                    ),
              ),
              SizedBox(
                height: 6,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.task_title,
                        hintStyle: TextStyle(
                            color: provider.isDarkMode()
                                ? mytheme.white
                                : mytheme.black),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.task_details,
                        hintStyle: TextStyle(
                            color: provider.isDarkMode()
                                ? mytheme.white
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
                                ? mytheme.white
                                : mytheme.black,
                          ),
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
                                  ? mytheme.white
                                  : mytheme.black,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                        onPressed: () {
                          addtask();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.save_changes,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: provider.isDarkMode()
                                        ? mytheme.white
                                        : mytheme.white,
                                  ),
                        )),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void showcalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }

  void addtask() {
    if (formkey.currentState?.validate() == true) {}
  }
}
