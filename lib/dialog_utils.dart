import 'package:flutter/material.dart';

class dialogUtils{
  static void showLoading(BuildContext context ,String message){
    showDialog(
      barrierDismissible: false ,
        context: context,
        builder: (context){
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 12,),
                Text(message,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),),
              ],
            ),
          );
        },

    );
  }

  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context,
      String message,
      {String title = 'Title' ,
        String? posActionName ,
        VoidCallback? posAction,
        String? negActionName ,
        VoidCallback? negAction,
        bool isDismissible = false ,
      }){
    List<Widget> actions = [];
    if(posActionName != null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName))
      );
    }
    if(negActionName != null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName))
      );
    }
    showDialog(
      barrierDismissible: isDismissible,
        context: context,
        builder: (context){
         return AlertDialog(
           title: Text(title,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
           content: Text(message,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
           actions: actions,
           titleTextStyle: TextStyle(
             color: Theme.of(context).primaryColor ,
             fontSize: 18,

           ),
         );
        }
    );
  }
}