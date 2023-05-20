import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rvi_analyzer/service/common_service.dart';
import 'package:rvi_analyzer/views/common/success_popup_reset_password.dart';
import 'package:rvi_analyzer/service/login_service.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';

class ResetPassword extends StatefulWidget {
  final String jwt;
  const ResetPassword({Key? key, required this.jwt}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  bool signInPressed = false;
  int selectedId = 0;

  var isValid = false;

  void checkValues() {
    if (confirmPasswordController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      setState(() {
        isValid = true;
      });
    } else {
      setState(() {
        isValid = false;
      });
    }
  }

  void setSelectedId(int id) {
    setState(() {
      selectedId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: isLandscape
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width < 600 ? width : (width / 2) - 50,
                            child: SizedBox(
                              height: height - 60,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: const Offset(0,
                                            0.5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(30.0),
                                    child: Image(
                                        image: AssetImage(
                                            'assets/images/logo.png')),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: width < 600 ? width : (width / 2) - 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Setup new password ',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  'Please create new password to sign in',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 122, 122, 122)),
                                ),
                                const SizedBox(height: 30.0),
                                Form(
                                  key: _formKey,
                                  onChanged: () => checkValues(),
                                  child: Column(
                                    children: [
                                      TextInput(
                                          data: TestInputData(
                                              controller: passwordController,
                                              validatorFun: (val) {
                                                if (val!.isEmpty) {
                                                  return "password cannot be empty";
                                                } else if (confirmPasswordController
                                                        .text.isNotEmpty &&
                                                    val.isNotEmpty) {
                                                  if (passwordController.text ==
                                                      confirmPasswordController
                                                          .text) {
                                                    null;
                                                  } else {
                                                    return "Passwords didn't match";
                                                  }
                                                } else {
                                                  null;
                                                }
                                              },
                                              labelText: 'New Password',
                                              textInputAction:
                                                  TextInputAction.done,
                                              obscureText: true)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextInput(
                                          data: TestInputData(
                                              controller:
                                                  confirmPasswordController,
                                              validatorFun: (val) {
                                                if (val!.isEmpty) {
                                                  return "password cannot be empty";
                                                } else if (passwordController
                                                        .text.isNotEmpty &&
                                                    val.isNotEmpty) {
                                                  if (passwordController.text ==
                                                      confirmPasswordController
                                                          .text) {
                                                    null;
                                                  } else {
                                                    return "Passwords didn't match";
                                                  }
                                                } else {
                                                  null;
                                                }
                                              },
                                              labelText: 'Re Enter Password',
                                              textInputAction:
                                                  TextInputAction.done,
                                              obscureText: true)),
                                      const SizedBox(height: 20.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 60,
                                              child: CupertinoButton.filled(
                                                disabledColor: Colors.grey,
                                                onPressed: isValid &&
                                                        !signInPressed
                                                    ? () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          resetPass(context);
                                                        }
                                                      }
                                                    : null,
                                                child: signInPressed
                                                    ? const SpinKitWave(
                                                        color: Colors.white,
                                                        size: 20.0,
                                                      )
                                                    : const Text(
                                                        'SET NEW PASSWORD',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    231,
                                                                    230,
                                                                    230)),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                  : Center(
                      child: SizedBox(
                        width: width,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height / 5,
                                ),
                                const Text(
                                  'Setup new password ',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  'Please create new password to sign in',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 122, 122, 122)),
                                ),
                                const SizedBox(height: 30.0),
                                Form(
                                  key: _formKey,
                                  onChanged: () => checkValues(),
                                  child: Column(
                                    children: [
                                      TextInput(
                                          data: TestInputData(
                                              controller: passwordController,
                                              validatorFun: (val) {
                                                if (val!.isEmpty) {
                                                  return "password cannot be empty";
                                                } else if (passwordController
                                                        .text.isNotEmpty &&
                                                    val.isNotEmpty) {
                                                  if (passwordController.text ==
                                                      confirmPasswordController
                                                          .text) {
                                                    null;
                                                  } else {
                                                    return "Passwords didn't match";
                                                  }
                                                } else {
                                                  null;
                                                }
                                              },
                                              labelText: 'Password',
                                              textInputAction:
                                                  TextInputAction.done,
                                              obscureText: true)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextInput(
                                          data: TestInputData(
                                              controller:
                                                  confirmPasswordController,
                                              validatorFun: (val) {
                                                if (val!.isEmpty) {
                                                  return "password cannot be empty";
                                                } else if (passwordController
                                                        .text.isNotEmpty &&
                                                    val.isNotEmpty) {
                                                  if (passwordController.text ==
                                                      confirmPasswordController
                                                          .text) {
                                                    null;
                                                  } else {
                                                    return "Passwords didn't match";
                                                  }
                                                } else {
                                                  null;
                                                }
                                              },
                                              labelText: 'Re Enter Password',
                                              textInputAction:
                                                  TextInputAction.done,
                                              obscureText: true)),
                                      const SizedBox(height: 20.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 60,
                                              child: CupertinoButton.filled(
                                                disabledColor: Colors.grey,
                                                onPressed: isValid &&
                                                        !signInPressed
                                                    ? () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          resetPass(context);
                                                        }
                                                      }
                                                    : null,
                                                child: signInPressed
                                                    ? const SpinKitWave(
                                                        color: Colors.white,
                                                        size: 20.0,
                                                      )
                                                    : const Text(
                                                        'SET NEW PASSWORD',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    231,
                                                                    230,
                                                                    230)),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPass(BuildContext context) {
    if (true) {
      setState(() {
        signInPressed = true;
      });
      //After successful login we will redirect to profile page. Let's create profile page now
      resetPassword(widget.jwt, passwordController.text).then((value) => {
            if (value.status == "S1000")
              {
                showSuccessCommonDialogPR(
                    context, "Password reset successful. Please login again")
              }
            else
              {
                setState(() {
                  signInPressed = false;
                }),
                showErrorDialog(
                    context, "Something went wrong. Please try again later")
              }
          });
    }
  }
}
