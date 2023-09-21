import 'package:flutter/material.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/TaskList/TaskEdit.dart';
import 'package:todo/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/app_config_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context)=>appConfigProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appConfigProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: homescreen.routename,
        routes: {
        homescreen.routename : (context)=> homescreen(),
         taskedit.routename : (context)=> taskedit()
        },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale:Locale(provider.appLanguage),
        theme: mytheme.lighttheme,
      darkTheme: mytheme.darkTheme,
      themeMode: provider.appTheme,

    );
  }
}
