import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/LoginScreen/LoginScreen.dart';
import 'package:todo/TextFormField.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/firebase_utils/firebase_utils.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/my_theme.dart';

import '../providers/auth_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_provider.dart';

class registerScreen extends StatefulWidget {
  static const String routename = "register";

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  var nameController = TextEditingController(text: 'ahmed');

  var emailController = TextEditingController(text: 'ahmed@route.com');

  var passwordController = TextEditingController(text: '123456');

  var confirmationController = TextEditingController(text: '123456');

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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    customTextFormField(
                        label: 'User Name',
                        controller: nameController,
                        myValidator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter User Name';
                          }
                          return null;
                        }),
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
                    customTextFormField(
                        label: 'Confirmation Password',
                        controller: confirmationController,
                        isPassword: true,
                        keyboardtype: TextInputType.phone,
                        myValidator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Confirmation Password';
                          }
                          if (text != passwordController.text) {
                            return "Password doesn't Match";
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
                            'Register',
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
                          "Already have an account? ",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: mytheme.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(loginScreen.routename);
                            },
                            child: Text('SignIn',
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
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid,
            name: nameController.text,
            email: emailController.text);
        var authprovider = Provider.of<AuthProvider>(context, listen: false);
        authprovider.updateUser(myUser);
        await firebaseutils.addUsertofirebase(myUser);
        dialogUtils.hideLoading(context);
        dialogUtils.showMessage(
            context,
            title: 'Success',
            'Register Succeussfully',
            posActionName: 'Ok', posAction: () {
          Navigator.of(context).pushReplacementNamed(homescreen.routename);
        });
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Something went wrong';

        if (e.code == 'weak-password') {
          dialogUtils.hideLoading(context);
          errorMessage = 'The password provided is too weak.';
          dialogUtils.showMessage(context, errorMessage);
        } else if (e.code == 'email-already-in-use') {
          dialogUtils.hideLoading(context);
          errorMessage = 'The account already exists for that email.';
          dialogUtils.showMessage(context, errorMessage);
        }
      } catch (e) {
        dialogUtils.hideLoading(context);
        dialogUtils.showMessage(context, e.toString());
      }
    }
  }
}
