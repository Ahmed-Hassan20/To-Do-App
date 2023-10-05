import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/TaskList/TaskEdit.dart';
import 'package:todo/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/auth_provider.dart';
import 'package:todo/register/register.dart';
import 'LoginScreen/LoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => appConfigProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appConfigProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: loginScreen.routename,
      routes: {
        homescreen.routename: (context) => homescreen(),
        taskedit.routename: (context) => taskedit(),
        registerScreen.routename: (context) => registerScreen(),
        loginScreen.routename: (context) => loginScreen()
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      theme: mytheme.lighttheme,
      darkTheme: mytheme.darkTheme,
      themeMode: provider.appTheme,
    );
  }
}
