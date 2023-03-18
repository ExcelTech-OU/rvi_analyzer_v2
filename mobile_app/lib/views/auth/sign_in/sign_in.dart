import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rvi_analyzer/views/common/form_eliments/check_box_with_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rvi_analyzer/service/common_service.dart';
import 'package:rvi_analyzer/views/dashboard/dashboard.dart';
import 'package:rvi_analyzer/service/login_service.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool signInPressed = false;
  bool termsAndConditionValue = false;
  bool privacyPolicyValue = false;
  int selectedId = 0;

  var isValid = false;

  void checkValues() {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        termsAndConditionValue &&
        privacyPolicyValue) {
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
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                  child: const SizedBox.shrink()),
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
                                SizedBox(
                                  height: height / 8,
                                ),
                                const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  'Please sign in to continue',
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
                                              controller: usernameController,
                                              validatorFun: (val) {
                                                if (val!.isEmpty) {
                                                  return "Email cannot be empty";
                                                } else {
                                                  null;
                                                }
                                              },
                                              labelText: 'Email')),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextInput(
                                          data: TestInputData(
                                              controller: passwordController,
                                              validatorFun: (val) {
                                                if (val!.isEmpty) {
                                                  return "password cannot be empty";
                                                } else {
                                                  null;
                                                }
                                              },
                                              labelText: 'Password',
                                              textInputAction:
                                                  TextInputAction.done,
                                              obscureText: true)),
                                      const SizedBox(height: 20.0),
                                      CheckBoxWithLabel(
                                          data: CheckBoxWithLabelData(
                                              headingText:
                                                  "By continuing you accept our ",
                                              linkText: "Privacy Policy",
                                              additionalFun: (p0) {
                                                setState(() {
                                                  privacyPolicyValue =
                                                      p0 ?? false;
                                                });
                                                checkValues();
                                              },
                                              validatorFun: (selectValue) {
                                                if (selectValue != null &&
                                                    selectValue == false) {
                                                  return 'You need to accept privacy policy';
                                                } else {
                                                  return null;
                                                }
                                              })),
                                      CheckBoxWithLabel(
                                          data: CheckBoxWithLabelData(
                                              headingText:
                                                  "By continuing you accept our ",
                                              linkText: "Terms & Conditions",
                                              additionalFun: (p0) {
                                                setState(() {
                                                  termsAndConditionValue =
                                                      p0 ?? false;
                                                });
                                                checkValues();
                                              },
                                              validatorFun: (selectValue) {
                                                if (selectValue != null &&
                                                    selectValue == false) {
                                                  return 'You need to accept terms and conditions';
                                                } else {
                                                  return null;
                                                }
                                              })),
                                      const SizedBox(
                                        height: 10,
                                      ),
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
                                                          nativeLogin(context);
                                                        }
                                                      }
                                                    : null,
                                                child: signInPressed
                                                    ? const SpinKitWave(
                                                        color: Colors.white,
                                                        size: 20.0,
                                                      )
                                                    : const Text(
                                                        'LOGIN',
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
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  'Please sign in to continue',
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
                                              controller: usernameController,
                                              validatorFun: (val) {
                                                if (val!.isEmpty) {
                                                  return "Email cannot be empty";
                                                } else {
                                                  null;
                                                }
                                              },
                                              labelText: 'Email')),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextInput(
                                          data: TestInputData(
                                              controller: passwordController,
                                              validatorFun: (val) {
                                                if (val!.isEmpty) {
                                                  return "password cannot be empty";
                                                } else {
                                                  null;
                                                }
                                              },
                                              labelText: 'Password',
                                              textInputAction:
                                                  TextInputAction.done,
                                              obscureText: true)),
                                      const SizedBox(height: 20.0),
                                      CheckBoxWithLabel(
                                          data: CheckBoxWithLabelData(
                                              headingText:
                                                  "By continuing you accept our ",
                                              linkText: "Privacy Policy",
                                              additionalFun: (p0) {
                                                setState(() {
                                                  privacyPolicyValue =
                                                      p0 ?? false;
                                                });
                                                checkValues();
                                              },
                                              validatorFun: (selectValue) {
                                                if (selectValue != null &&
                                                    selectValue == false) {
                                                  return 'You need to accept privacy policy';
                                                } else {
                                                  return null;
                                                }
                                              })),
                                      CheckBoxWithLabel(
                                          data: CheckBoxWithLabelData(
                                              headingText:
                                                  "By continuing you accept our ",
                                              linkText: "Terms & Conditions",
                                              additionalFun: (p0) {
                                                setState(() {
                                                  termsAndConditionValue =
                                                      p0 ?? false;
                                                });
                                                checkValues();
                                              },
                                              validatorFun: (selectValue) {
                                                if (selectValue != null &&
                                                    selectValue == false) {
                                                  return 'You need to accept terms and conditions';
                                                } else {
                                                  return null;
                                                }
                                              })),
                                      const SizedBox(
                                        height: 10,
                                      ),
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
                                                          nativeLogin(context);
                                                        }
                                                      }
                                                    : null,
                                                child: signInPressed
                                                    ? const SpinKitWave(
                                                        color: Colors.white,
                                                        size: 20.0,
                                                      )
                                                    : const Text(
                                                        'LOGIN',
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

  void nativeLogin(BuildContext context) {
    if (true) {
      setState(() {
        signInPressed = true;
      });
      //After successful login we will redirect to profile page. Let's create profile page now
      login(usernameController.text, passwordController.text).then((value) => {
            if (value.state == "S1000")
              {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashboardPage(
                              initialIndex: 0,
                            )))
              }
            else if (value.state == "E1005")
              {
                setState(() {
                  signInPressed = false;
                }),
                showErrorDialog(context,
                    "You account temporally disabled. Please contact Administrator")
              }
            else
              {
                setState(() {
                  signInPressed = false;
                }),
                showErrorDialog(context, "Username or Password Invalid")
              }
          });
    }
  }
}
