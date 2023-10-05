import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/LoginScreen/LoginScreen.dart';
import 'package:todo/Settings/settings.dart';
import 'package:todo/TaskList/TaskList.dart';
import 'package:todo/TaskList/addtaskbottomsheet.dart';
import 'package:todo/bottom_nav_item.dart';
import 'package:todo/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/auth_provider.dart';

class homescreen extends StatefulWidget {
static const String routename="homescreen";

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
int selectedindex=0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appConfigProvider>(context);
    var authprovider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
appBar: AppBar(
  title:Text('${AppLocalizations.of(context)!.app_title} ${authprovider.currentUser?.name}',style: Theme.of(context).textTheme.titleMedium!.copyWith(
    color: provider.isDarkMode() ?
    mytheme.black
        :
    mytheme.white),

),
actions: [IconButton(onPressed: (){
  provider.tasklist=[];
  authprovider.currentUser=null;
  Navigator.pushNamed(context,loginScreen.routename);
}, icon: Icon(Icons.logout))],),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: BottomNavigationBar(
            currentIndex: selectedindex,
            onTap: (index) {
              selectedindex = index;
              setState(() {});
            },
          items: [

bottom_nav_item(label:AppLocalizations.of(context)!.task_list, icon:Icon(Icons.list) ),
          bottom_nav_item(label: AppLocalizations.of(context)!.settings, icon: Icon(Icons.settings))
        ],),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { showaddtaskbottomsheet(); },
        shape: StadiumBorder(side: BorderSide(
          width: 4,
              color:mytheme.white
        )),
        child:Icon(Icons.add,size: 30,) ,
      ),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
body: tabs[selectedindex],
    );

  }
  List<Widget>tabs=[tasklist(),settings()];

  void showaddtaskbottomsheet() {
    showModalBottomSheet(context: context, builder: (context)=>addtaskbottomsheet());
  }
}
