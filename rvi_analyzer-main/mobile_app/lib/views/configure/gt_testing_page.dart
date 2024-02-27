import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: GtTestingPage(),
  ));
}

class GtTestingPage extends StatefulWidget {
  const GtTestingPage({Key? key}) : super(key: key);

  @override
  State<GtTestingPage> createState() => _GtSettingState();
}

class _GtSettingState extends State<GtTestingPage> {
  final _gtTestingFormKey = GlobalKey<FormState>();
  final TextEditingController macAddressController = TextEditingController();
  final TextEditingController voltageController = TextEditingController();
  final TextEditingController amperageController = TextEditingController();
  final TextEditingController resistanceController = TextEditingController();
  String voltage = '40';
  String amperage = '8';
  String resistance = '';
  bool ledSequence = false;
  Color? passButtonColor = Colors.grey;
  Color? failButtonColor = Colors.grey;

  void calculateResistance(String v, String i) {
    setState(() {
      resistance = (double.parse(voltage) / double.parse(amperage)).toString();
      voltage = v;
      amperage = i;
      resistanceController.text = resistance;
      voltageController.text = voltage;
      amperageController.text = amperage;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    macAddressController.text = "132:rf:85:cc:7s:22";
    print(resistance);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: deviceWidth,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 0.5), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                key: _gtTestingFormKey,
                child: Row(children: [
                  SizedBox(
                    width: (deviceWidth / 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 0.5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'GamerTech Testing',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 400.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              height: 60.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Mac Address",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey[340],
                                      height: 40.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: TextFormField(
                                        readOnly: true,
                                        onChanged: (value) {},
                                        textAlign: TextAlign.start,
                                        controller: macAddressController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(12, 12, 8, 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 400.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              height: 60.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 150,
                                    child: Text(
                                      "Voltage (V)",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Container(
                                      height: 40.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: TextFormField(
                                        textAlign: TextAlign.start,
                                        readOnly: true,
                                        controller: voltageController,
                                        onChanged: (value) {
                                          // setState(() {
                                          //   soNumber = value;
                                          // });
                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(12, 12, 8, 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 400.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              height: 60.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 150,
                                    child: Text(
                                      "Amperage (I)",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Container(
                                      height: 40.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: TextFormField(
                                        textAlign: TextAlign.start,
                                        readOnly: true,
                                        controller: amperageController,
                                        onChanged: (value) {
                                          // setState(() {
                                          //   soNumber = value;
                                          // });
                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(12, 12, 8, 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 400.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              height: 60.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 150,
                                    child: Text(
                                      "Resistance (R)",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Container(
                                      height: 40.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: TextFormField(
                                        textAlign: TextAlign.start,
                                        readOnly: true,
                                        controller: resistanceController,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(12, 12, 8, 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 400.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              height: 60.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "LED Sequence",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Container(
                                      height: 40.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: CupertinoButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          setState(() {
                                            ledSequence = false;
                                            failButtonColor = Colors.red;
                                            passButtonColor = Colors.grey;
                                          });
                                        },
                                        color: failButtonColor,
                                        child: const Text(
                                          'Fail',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: CupertinoButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          setState(() {
                                            ledSequence = true;
                                            passButtonColor = Colors.green;
                                            failButtonColor = Colors.grey;
                                          });
                                        },
                                        color: passButtonColor,
                                        child: const Text(
                                          'Pass',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 400.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              height: 60.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 55.0,
                                      // padding: const EdgeInsets.symmetric(
                                      //     horizontal: 5.0),
                                      child: CupertinoButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {},
                                        disabledColor: Colors.grey,
                                        color: Colors.red,
                                        child: const Text(
                                          'Stop',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 55.0,
                                      // padding: const EdgeInsets.symmetric(
                                      //     horizontal: 5.0),
                                      child: CupertinoButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          calculateResistance("30", "6");
                                        },
                                        color: Colors.green,
                                        disabledColor: Colors.grey,
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
