import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';

import '../providers/app_config_provider.dart';
import 'LanguagebottomSheet.dart';
import 'ThemeBottomSheet.dart';

class settings extends StatefulWidget {
  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appConfigProvider>(context);

    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: provider.isDarkMode()
                      ? mytheme.grey
                      : mytheme.black,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: provider.isDarkMode()
                      ? mytheme.darkblack
                      : mytheme.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLanguage == 'en'
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
    color: provider.isDarkMode()
    ? mytheme.primarycolor
        : mytheme.primarycolor
                  )),
                  Icon(Icons.arrow_drop_down,color: provider.isDarkMode()
                      ? mytheme.primarycolor
                      : mytheme.primarycolor,)
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: provider.isDarkMode()
                      ? mytheme.grey
                      : mytheme.black,
                ),
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    provider.isDarkMode() ? mytheme.darkblack : mytheme.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.isDarkMode()
                        ? AppLocalizations.of(context)!.dark
                        : AppLocalizations.of(context)!.light,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: provider.isDarkMode()
                            ? mytheme.primarycolor
                            : mytheme.primarycolor
                    ),
                  ),
                  Icon(Icons.arrow_drop_down,color: provider.isDarkMode()
                      ? mytheme.primarycolor
                      : mytheme.primarycolor,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => languagebottomsheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
}
