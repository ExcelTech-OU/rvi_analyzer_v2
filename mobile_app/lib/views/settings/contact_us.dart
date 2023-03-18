import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 0, 12, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(
                          image:
                              AssetImage('assets/images/technical_support.png'),
                          width: 92,
                          height: 92,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Full name',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 148, 163, 184)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextInput(
                        data: TestInputData(
                            controller: nameController,
                            validatorFun: (val) {
                              if (val!.isEmpty) {
                                return "Name cannot be empty";
                              } else {
                                null;
                              }
                            },
                            labelText: '')),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 148, 163, 184)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextInput(
                        data: TestInputData(
                            controller: emailController,
                            validatorFun: (val) {
                              if (val!.isEmpty) {
                                return "Email cannot be empty";
                              } else {
                                null;
                              }
                            },
                            labelText: '')),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Message',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 148, 163, 184)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextInput(
                        data: TestInputData(
                      controller: messageController,
                      validatorFun: (val) {
                        if (val!.isEmpty) {
                          return "Message cannot be empty";
                        } else {
                          null;
                        }
                      },
                      labelText: '',
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 60,
            child: CupertinoButton.filled(
              disabledColor: Colors.grey,
              onPressed: _formKey.currentState != null &&
                      _formKey.currentState!.validate()
                  ? () {}
                  : null,
              child: const Text('Send',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 253, 253))),
            ),
          )),
    );
  }
}
