import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/TextFormField.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/firebase_utils/firebase_utils.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/register/register.dart';

import '../providers/auth_provider.dart';

class loginScreen extends StatefulWidget {
  static const String routename = "login";

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var emailController = TextEditingController(text: 'ahmed@route.com');

  var passwordController = TextEditingController(text: '123456');

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mytheme.bglight,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/1.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                    customTextFormField(
                      label: 'Email Address',
                      controller: emailController,
                      myValidator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Email Address';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                    customTextFormField(
                        label: 'Password',
                        controller: passwordController,
                        isPassword: true,
                        keyboardtype: TextInputType.phone,
                        myValidator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Password';
                          }
                          if (text.length < 6) {
                            return 'Password should be at least 6 chars';
                          }
                          return null;
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            register();
                          },
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: mytheme.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(registerScreen.routename);
                            },
                            child: Text('SignUp',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: mytheme.primarycolor)))
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Future<void> register() async {
    if (formkey.currentState!.validate() == true) {
      dialogUtils.showLoading(context, 'Loading...');

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

       var user=await firebaseutils.reafUserFromFirestore(credential.user?.uid??'');

       if(user==null){
         return;
       }
        var authprovider = Provider.of<AuthProvider>(context, listen: false);
        authprovider.updateUser(user);
        dialogUtils.hideLoading(context);
        dialogUtils.showMessage(
            context,
            title: 'Success',
            'Login Succeussfully',
            posActionName: 'Ok', posAction: () {
          Navigator.of(context).pushReplacementNamed(homescreen.routename);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          dialogUtils.hideLoading(context);
          dialogUtils.showMessage(context, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          dialogUtils.hideLoading(context);
          dialogUtils.showMessage(
              context, 'Wrong password provided for that user.');
        }
      } catch (e) {
        dialogUtils.hideLoading(context);
        dialogUtils.showMessage(context, e.toString());
      }
    }
  }
}
