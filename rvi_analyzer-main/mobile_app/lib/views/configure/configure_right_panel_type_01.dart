import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/views/configure/mode_setting.dart';
import 'package:rvi_analyzer/views/configure/qr_scanner.dart';

class ConfigureRightPanelType01 extends ConsumerStatefulWidget {
  final ScanResult sc;
  final GlobalKey<FormState> keyForm;
  final void Function() updateTestId;

  const ConfigureRightPanelType01({
    Key? key,
    required this.sc,
    required this.keyForm,
    required this.updateTestId,
  }) : super(key: key);

  @override
  ConsumerState<ConfigureRightPanelType01> createState() =>
      _ConfigureRightPanelType01State();
}

class _ConfigureRightPanelType01State
    extends ConsumerState<ConfigureRightPanelType01> {
  Blue blue = Blue();
  final _formKey = GlobalKey<FormState>();
  bool showResult = false;
  String qrCode = '';
  String parameterMode01Value = '';
  String parameterMode02Value = '';
  String parameterMode03Value = '';
  String parameterMode04Value = '';
  String plantValue = '';
  String customerValue = '';
  String styleValue = '';
  String rm = '';
  String customerpo = '';
  String sono = '';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SizedBox(
      width: isLandscape ? (width / 3) * 2 - 32 : width,
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mode 01",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModeSettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 2.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              getScrollView(),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getScrollView() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                  child: SizedBox(
                    width: 325.0,
                    height: 200.0,
                    child: Center(
                      child: Text(
                        'Customer: $customerValue\nPlant: $plantValue\nStyle: $styleValue\nRM: $rm\nCustomer PO: $customerpo\nSO NO: $sono ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                  child: SizedBox(
                    width: 200.0,
                    height: 25.0,
                    child: Center(
                      child: Text(
                        'Text ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                  width: 120.0,
                  height: 40.0,
                  child: DropdownButton<String>(
                    value: parameterMode01Value,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          parameterMode01Value = newValue;
                        });
                      }
                    },
                    items: <String>[
                      '',
                      'Option 1',
                      'Option 2',
                      'Option 3',
                      'Option 4',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                  child: SizedBox(
                    width: 200.0,
                    height: 25.0,
                    child: Center(
                      child: Text(
                        'Production Order',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                  width: 120.0,
                  height: 40.0,
                  child: DropdownButton<String>(
                    value: parameterMode02Value,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          parameterMode02Value = newValue;
                        });
                      }
                    },
                    items: <String>[
                      '',
                      'Option 1',
                      'Option 2',
                      'Option 3',
                      'Option 4',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                  child: SizedBox(
                    width: 200.0,
                    height: 25.0,
                    child: Center(
                      child: Text(
                        'Production ID',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 120.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRScanner(
                            updateQRCode: setQRCode,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'QR Scan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                  child: SizedBox(
                    width: 200.0,
                    height: 25.0,
                    child: Center(
                      child: Text(
                        'Parameter Mode 03',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 120.0,
                  height: 40.0,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        parameterMode03Value = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Value',
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                  child: SizedBox(
                    width: 200.0,
                    height: 25.0,
                    child: Center(
                      child: Text(
                        'Parameter Mode 04',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 120.0,
                  height: 40.0,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        parameterMode04Value = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Value',
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                  child: SizedBox(
                    width: 200.0,
                    height: 25.0,
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 120.0,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: onSaveButtonPressed,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updateSessionID() {
    DateTime now = DateTime.now();
    int milliseconds = now.millisecondsSinceEpoch;

    ref.watch(deviceDataMap[widget.sc.device.id.id]!).sessionIdController.text =
        "S_$milliseconds";
  }

  void onSaveButtonPressed() {
    print('Save button pressed!');
    print('Parameter Mode 01: $parameterMode01Value');
    print('Parameter Mode 02: $parameterMode02Value');
    print('Parameter Mode 03: $parameterMode03Value');
    print('Parameter Mode 04: $parameterMode04Value');
    // Add any additional save logic you need
  }

  void setQRCode(String? code) {
    if (code != null) {
      setState(() {
        qrCode = code;
      });
    }
  }
}
