import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MasterReset extends StatefulWidget {
  const MasterReset({Key? key}) : super(key: key);

  @override
  State<MasterReset> createState() => _MasterResetState();
}

class _MasterResetState extends State<MasterReset> {
  final passwordController = TextEditingController();
  bool formValid = false;
  bool isMasterReset = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Master Reset")),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: isMasterReset
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image(
                            image: AssetImage('assets/images/device-icon.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const SizedBox(
                        width: 200,
                        height: 200,
                        child: Image(
                          image: AssetImage('assets/images/device-icon.png'),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CupertinoFormSection(
                          children: [
                            CupertinoTextFormFieldRow(
                              obscureText: true,
                              placeholder: 'Please enter Master Password',
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              prefix: const Icon(CupertinoIcons.lock),
                              controller: passwordController,
                              onChanged: (value) => {
                                setState(
                                  () => value.isEmpty
                                      ? formValid = false
                                      : formValid = true,
                                )
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "password cannot be empty";
                                } else {
                                  null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isMasterReset
            ? SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoButton.filled(
                          padding: const EdgeInsets.all(10),
                          onPressed: () {
                            setState(() {
                              isMasterReset = false;
                            });
                          },
                          child: const CupertinoActivityIndicator()),
                    ),
                  ],
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: CupertinoButton.filled(
                      padding: const EdgeInsets.all(10),
                      onPressed: () {},
                      child: const Text('Cancel',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CupertinoButton.filled(
                      padding: const EdgeInsets.all(10),
                      onPressed: () {
                        setState(() {
                          isMasterReset = true;
                        });
                      },
                      child: const Text('Master Reset',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
