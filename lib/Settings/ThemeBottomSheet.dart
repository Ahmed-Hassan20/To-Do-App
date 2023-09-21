import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import '../providers/app_config_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
   var provider = Provider.of<appConfigProvider>(context);
    return Container(
      color: provider.isDarkMode() ?
      mytheme.darkblack
          :
      mytheme.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
             provider.changeTheme(ThemeMode.light);
            },
            child: provider.isDarkMode()?
            getUnSelectedItemWidget(AppLocalizations.of(context)!.light)
                :getSelectedItemWidget(AppLocalizations.of(context)!.light)
            ,
          ),
          InkWell(
              onTap: (){
                provider.changeTheme(ThemeMode.dark);
              },
              child:provider.isDarkMode()?
    getSelectedItemWidget(AppLocalizations.of(context)!.dark)
        :getUnSelectedItemWidget(AppLocalizations.of(context)!.dark))
          ,
        ],
      ),
    );
  }
  Widget getSelectedItemWidget(String text){
    var provider = Provider.of<appConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: provider.isDarkMode() ?
              mytheme.primarycolor
                  :
              mytheme.primarycolor,
            ),
          ),
          Icon(Icons.check ,
            color: provider.isDarkMode() ?
            mytheme.primarycolor
                :
            mytheme.primarycolor,
            size: 30,
          )
        ],
      ),
    );
  }
  Widget getUnSelectedItemWidget(String text){
    var provider = Provider.of<appConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text ,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: provider.isDarkMode() ? mytheme.grey : mytheme.black),
      ),
    );
  }
}


