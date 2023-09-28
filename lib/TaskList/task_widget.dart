import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils/firebase_utils.dart';
import 'package:todo/model/task.dart';
import 'package:todo/my_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/app_config_provider.dart';

class taskwidget extends StatelessWidget {
  task Task;
  taskwidget({required this.Task});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appConfigProvider>(context);
   var listprovider = Provider.of<appConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                firebaseutils
                    .deletetaskfromfirebase(Task)
                    .timeout(Duration(milliseconds: 500),
                    onTimeout: () {
                      print('deleted********');
                      listprovider.getAlltasksFromForestore();

                    }
                );
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: Container(

          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: provider.isDarkMode() ? mytheme.darkblack : mytheme.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: mytheme.primarycolor,
                height: 80,
                width: 4,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Task.title ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: mytheme.primarycolor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Task.description ?? '',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ],
              )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: mytheme.primarycolor),
                child: Icon(Icons.check, size: 40, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
