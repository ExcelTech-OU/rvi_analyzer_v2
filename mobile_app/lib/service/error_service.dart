import 'package:rvi_analyzer/views/errors/master_reset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showLevelThreeDialog(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
            insetPadding:
                EdgeInsets.fromLTRB(20, height * .15, 20, height * .15),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: const Center(
                child: Text(
              'Level 03 Major Error',
              style: TextStyle(
                  color: CupertinoColors.systemRed,
                  fontWeight: FontWeight.bold),
            )),
            content: SizedBox(
              height: height - 1,
              width: width - 10,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Please contact agent  &"),
                        Text("Master reset the device"),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Image(
                            image: AssetImage('assets/images/device-icon.png'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                  width: width - 10,
                  height: 50,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CupertinoButton.filled(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MasterReset()));
                            },
                            child: const Text('Master Reset',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ),
                        ),
                      ]))
            ]);
      });
    },
  );
}

Future<void> showLevelOneDialog(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
            insetPadding:
                EdgeInsets.fromLTRB(20, height * .15, 20, height * .15),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: const Center(
                child: Text(
              'Level 01 Error',
              style: TextStyle(
                  color: CupertinoColors.systemRed,
                  fontWeight: FontWeight.bold),
            )),
            content: SizedBox(
              height: height - 1,
              width: width - 10,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Expanded(flex: 2, child: Text('Error code :')),
                            Expanded(flex: 1, child: Text("")),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: const [
                            Expanded(
                                flex: 2, child: Text('Error description :')),
                            Expanded(flex: 1, child: Text("")),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          width: 150,
                          height: 150,
                          child: Image(
                            image: const AssetImage(
                                'assets/images/device-icon.png'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                  width: width - 10,
                  height: 50,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CupertinoButton.filled(
                            padding: const EdgeInsets.all(10),
                            onPressed: () {},
                            child: const Text('Stop',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: CupertinoButton.filled(
                            padding: const EdgeInsets.all(10),
                            onPressed: () {},
                            child: const Text('Resume',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: CupertinoButton.filled(
                            padding: const EdgeInsets.all(10),
                            onPressed: () {},
                            child: const Text('Reset',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ),
                        ),
                      ]))
            ]);
      });
    },
  );
}

Future<void> showLevelThreeErrorDialog(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
            insetPadding:
                EdgeInsets.fromLTRB(20, height * .15, 20, height * .15),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: const Center(
                child: Text(
              'Level 03 Error',
              style: TextStyle(
                  color: CupertinoColors.systemRed,
                  fontWeight: FontWeight.bold),
            )),
            content: SizedBox(
              height: height - 1,
              width: width - 10,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Expanded(flex: 2, child: Text('Error code :')),
                            Expanded(flex: 1, child: Text("")),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: const [
                            Expanded(
                                flex: 2, child: Text('Error description :')),
                            Expanded(flex: 1, child: Text("")),
                          ],
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        const SizedBox(
                          width: 150,
                          height: 150,
                          child: Image(
                            image: const AssetImage(
                                'assets/images/device-icon.png'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                  width: width - 10,
                  height: 50,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CupertinoButton.filled(
                            padding: const EdgeInsets.all(10),
                            onPressed: () {},
                            child: const Text('Reset',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ),
                        ),
                      ]))
            ]);
      });
    },
  );
}
