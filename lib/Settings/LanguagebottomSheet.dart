import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import '../providers/app_config_provider.dart';

class languagebottomsheet extends StatefulWidget {
  @override
  State<languagebottomsheet> createState() => _languagebottomsheetState();
}

class _languagebottomsheetState extends State<languagebottomsheet> {
  @override
  Widget build(BuildContext context) {
     var provider = Provider.of<appConfigProvider>(context);
    return Container(
      color: provider.isDarkMode() ? mytheme.darkblack : mytheme.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                provider.changeLanguage('en');

              },
              child:provider.appLanguage == 'en'
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
                  : getUnSelectedItemWidget(
                  AppLocalizations.of(context)!.english)),
          InkWell(
              onTap: () {
                provider.changeLanguage('ar');

              },
              child: provider.appLanguage == 'ar'
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
                  : getUnSelectedItemWidget(AppLocalizations.of(context)!.arabic)),
        ],
      ),
    );
  }
  Widget getSelectedItemWidget(String text) {
    var provider = Provider.of<appConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: provider.isDarkMode() ? mytheme.primarycolor : mytheme.primarycolor,
            ),
          ),
          Icon(
            Icons.check,
            color: provider.isDarkMode() ? mytheme.primarycolor : mytheme.primarycolor,
            size: 30,
          )
        ],
      ),
    );
  }
  Widget getUnSelectedItemWidget(String text) {
    var provider = Provider.of<appConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: provider.isDarkMode() ? mytheme.grey : mytheme.black),
      ),
    );
  }

}


