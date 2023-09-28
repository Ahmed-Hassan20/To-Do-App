import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/TaskList/TaskEdit.dart';
import 'package:todo/TaskList/task_widget.dart';
import 'package:todo/firebase_utils/firebase_utils.dart';
import 'package:todo/model/task.dart';
import 'package:todo/my_theme.dart';

import '../providers/app_config_provider.dart';

class tasklist extends StatefulWidget {
  @override
  State<tasklist> createState() => _tasklistState();
}

class _tasklistState extends State<tasklist> {
  List<task> tasklist=[];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appConfigProvider>(context);

    if(provider.tasklist.isEmpty){provider.getAlltasksFromForestore();}


    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: mytheme.white,
          dayColor: mytheme.white,
          activeDayColor: provider.isDarkMode() ? mytheme.white : mytheme.black,
          activeBackgroundDayColor: Theme.of(context).primaryColor,
          dotsColor: mytheme.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(taskedit.routename);
                  },
                  child: taskwidget(Task: provider.tasklist[index],));
            },
            itemCount: provider.tasklist.length,
          ),
        )
      ],
    );
  }


}
