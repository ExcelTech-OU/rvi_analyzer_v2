import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:rvi_analyzer/views/common/drop_down.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';
import 'package:intl/intl.dart';
import 'package:rvi_analyzer/views/configure/qr_scanner.dart';

class ConfigureLeftPanel extends StatefulWidget {
  final ScanResult sc;
  final void Function(DropDownItem) updateIndex;
  final int defaultIndex;
  final GlobalKey<FormState> keyForm;
  final bool started;
  final TextEditingController customerNameController;
  final TextEditingController batchNoController;
  final TextEditingController operatorIdController;
  final TextEditingController sessionIdController;
  final TextEditingController testIdController;
  final TextEditingController dateController;

  const ConfigureLeftPanel(
      {Key? key,
      required this.sc,
      required this.updateIndex,
      required this.defaultIndex,
      required this.keyForm,
      required this.started,
      required this.customerNameController,
      required this.batchNoController,
      required this.operatorIdController,
      required this.sessionIdController,
      required this.testIdController,
      required this.dateController})
      : super(key: key);

  @override
  State<ConfigureLeftPanel> createState() => _ConfigureLeftPanelState();
}

class _ConfigureLeftPanelState extends State<ConfigureLeftPanel> {
  List<DropDownItem> items = [];

  List<String> ModePositions = <String>[
    'Mode 01',
    'Mode 02',
    'Mode 03',
    'Mode 04',
    'Mode 05'
  ];

  void setQRCode(String? qrCode) {
    setState(() {
      if (qrCode != null) {
        widget.batchNoController.text = qrCode;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (ModePositions != null) {
      for (var item in ModePositions) {
        items.add(DropDownItem(item, null, ModePositions.indexOf(item)));
      }
    }
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(now);
    widget.dateController.text = date;

    int milliseconds = now.millisecondsSinceEpoch;
    widget.testIdController.text = milliseconds.toString();
    widget.sessionIdController.text = "S_$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SizedBox(
      width: isLandscape ? (width / 3) - 32 : width,
      child: SizedBox(
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
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sc.device.name,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  const Text(
                    'Analysis Configurations',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  getScrollBody(width)
                ],
              ),
            )),
      ),
    );
  }

  Widget getScrollBody(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select one of 5 options',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 65,
                child: CupertinoButton(
                  color: Colors.cyan,
                  padding: const EdgeInsets.all(0),
                  onPressed: widget.started
                      ? null
                      : () {
                          showModalBottomSheet(
                            constraints: BoxConstraints(
                              maxWidth: width / 3,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            context: context,
                            barrierColor: const Color.fromARGB(178, 0, 0, 0),
                            builder: (context) => DropDownCustom(DropDownData(
                                "Select Mode",
                                items,
                                widget.updateIndex,
                                widget.defaultIndex)),
                          );
                        },
                  child: Text(
                    widget.defaultIndex != -1
                        ? ModePositions[widget.defaultIndex]
                        : 'Select Mode',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Form(
          key: widget.keyForm,
          onChanged: () {},
          child: Column(
            children: [
              TextInput(
                  data: TestInputData(
                      controller: widget.customerNameController,
                      validatorFun: (val) {
                        if (val!.isEmpty) {
                          return "Customer Name cannot be empty";
                        } else {
                          null;
                        }
                      },
                      labelText: 'Customer Name',
                      enabled: !(widget.started))),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextInput(
                        data: TestInputData(
                            controller: widget.batchNoController,
                            validatorFun: (val) {
                              if (val!.isEmpty) {
                                return "Batch No cannot be empty";
                              } else {
                                null;
                              }
                            },
                            labelText: 'Batch No',
                            textInputAction: TextInputAction.done,
                            obscureText: false,
                            enabled: !widget.started)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    height: 55,
                    child: CupertinoButton(
                      color: Colors.cyan,
                      padding: const EdgeInsets.all(0),
                      onPressed: widget.started
                          ? null
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          QRScanner(updateQRCode: setQRCode)));
                            },
                      child: const Text(
                        'QR Scan',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                  data: TestInputData(
                      controller: widget.operatorIdController,
                      validatorFun: (val) {
                        if (val!.isEmpty) {
                          return "Operator Id cannot be empty";
                        } else {
                          null;
                        }
                      },
                      labelText: 'Operator ID',
                      enabled: !widget.started)),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                  data: TestInputData(
                      controller: widget.sessionIdController,
                      validatorFun: (val) {
                        if (val!.isEmpty) {
                          return "Session Id cannot be empty";
                        } else {
                          null;
                        }
                      },
                      labelText: 'Session ID',
                      enabled: !widget.started)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextInput(
                        data: TestInputData(
                            controller: widget.testIdController,
                            enabled: false,
                            validatorFun: (val) {
                              return null;
                            },
                            labelText: 'Test ID')),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextInput(
                        data: TestInputData(
                            controller: widget.dateController,
                            enabled: false,
                            validatorFun: (val) {
                              return null;
                            },
                            labelText: 'Date')),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
