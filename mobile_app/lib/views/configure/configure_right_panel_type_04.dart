import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';
import 'package:rvi_analyzer/views/common/test_line.dart';

class ConfigureRightPanelType04 extends ConsumerStatefulWidget {
  final ScanResult sc;
  final GlobalKey<FormState> keyForm;
  final void Function() updateStarted;
  final void Function() updateTestId;
  final TextEditingController customerNameController;
  final TextEditingController batchNoController;
  final TextEditingController operatorIdController;
  final TextEditingController sessionIdController;
  final TextEditingController testIdController;
  final TextEditingController dateController;
  const ConfigureRightPanelType04(
      {Key? key,
      required this.sc,
      required this.keyForm,
      required this.updateStarted,
      required this.updateTestId,
      required this.customerNameController,
      required this.batchNoController,
      required this.operatorIdController,
      required this.sessionIdController,
      required this.testIdController,
      required this.dateController})
      : super(key: key);

  @override
  ConsumerState<ConfigureRightPanelType04> createState() =>
      _ConfigureRightPanelType04State();
}

class _ConfigureRightPanelType04State
    extends ConsumerState<ConfigureRightPanelType04> {
  Blue blue = Blue();
  final _formKey = GlobalKey<FormState>();
  final startingCurrentController = TextEditingController();
  final desiredCurrentController = TextEditingController();
  final maxVoltageController = TextEditingController();
  final currentResolutionController = TextEditingController();
  final changeInTimeController = TextEditingController();

  bool started = false;
  bool saveClicked = false;
  bool passed = false;
  bool isNotInitial = false;

  double xMaxGraph01 = 0.0;
  double yMaxGraph01 = 0.2;
  List<FlSpot> spotDataGraph01 = [];
  double lastVoltage = 0.0;

  double xMaxGraph02 = 0.0;
  double yMaxGraph02 = 0.0;
  List<FlSpot> spotDataGraph02 = [];

  void setGraphValues() {
    if (started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
              .state ==
          6) {
        setState(() {
          started = false;
        });
      } else {
        if (ref
                .watch(
                    ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
                .currentProtocol ==
            4) {
          double currentReadingVoltage = ref
              .read(ref.read(deviceDataMap[widget.sc.device.name]!).streamData)
              .voltage;
          double currentReadingCurrent = ref
              .read(ref.read(deviceDataMap[widget.sc.device.name]!).streamData)
              .current;
          int currentReadingTem = ref
              .read(ref.read(deviceDataMap[widget.sc.device.name]!).streamData)
              .temperature;

          //Update when x axis value groth
          if (xMaxGraph01 < currentReadingCurrent) {
            if (yMaxGraph01 < currentReadingVoltage) {
              setState(() {
                if (yMaxGraph02 < currentReadingTem) {
                  yMaxGraph02 = currentReadingTem.toDouble();
                }
                xMaxGraph01 = currentReadingCurrent;
                yMaxGraph01 = currentReadingVoltage;
              });
            } else {
              setState(() {
                xMaxGraph01 = currentReadingCurrent;
              });
            }
          } else {
            if (yMaxGraph01 < currentReadingVoltage) {
              setState(() {
                yMaxGraph01 = currentReadingVoltage;
              });
            }
          }

          setState(() {
            spotDataGraph01
                .add(FlSpot(currentReadingCurrent, currentReadingVoltage));
            spotDataGraph02.add(
                FlSpot(currentReadingCurrent, currentReadingTem.toDouble()));
          });
        }
      }
    }
  }

  void saveModeOne() {
    // spots.add(FlSpot(8, 1));
    // double voltage = ref
    //     .read(ref.read(deviceDataMap[widget.sc.device.name]!).streamData)
    //     .voltage;
    // setState(() {
    //   saveClicked = true;
    // });

    // if (double.parse(minCurrentRangeController.text) < voltage &&
    //     voltage < double.parse(maxCurrentController.text)) {
    //   setState(() {
    //     passed = true;
    //   });
    // } else {
    //   setState(() {
    //     passed = false;
    //   });
    // }
    widget.updateTestId();
  }

  Widget getScrollView() {
    return Form(
      key: _formKey,
      onChanged: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextInput(
                    data: TestInputData(
                        inputType: TextInputType.number,
                        controller: startingCurrentController,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Starting current cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,2})?$")
                              .hasMatch(val)) {
                            return "Starting current ONLY allowed two Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Starting Current (A)',
                        enabled: !started)),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: TextInput(
                    data: TestInputData(
                        inputType: TextInputType.number,
                        controller: desiredCurrentController,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Desired Current cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,2})?$")
                              .hasMatch(val)) {
                            return "Desired Current ONLY allowed two Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Desired Current (V)',
                        enabled: !started)),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextInput(
                    data: TestInputData(
                        inputType: TextInputType.number,
                        controller: maxVoltageController,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Max Voltage cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1})?$")
                              .hasMatch(val)) {
                            return "Max voltage ONLY allowed one Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Max Voltage (A)',
                        enabled: !started)),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextInput(
                    data: TestInputData(
                        controller: currentResolutionController,
                        inputType: TextInputType.number,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Current resolution cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,2})?$")
                              .hasMatch(val)) {
                            return "Current resolution ONLY allowed two Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Current resolution',
                        enabled: !started)),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: TextInput(
                    data: TestInputData(
                        inputType: TextInputType.number,
                        controller: changeInTimeController,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Change in time cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,6}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Change in time (Sec)',
                        enabled: !started)),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          started
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Current",
                              spotData: spotDataGraph01,
                              xMax: xMaxGraph01,
                              yAxisName: "Voltage",
                              yMax: yMaxGraph01),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 10,
          ),
          started
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Current",
                              spotData: spotDataGraph02,
                              xMax: xMaxGraph01,
                              yAxisName: "Temperature",
                              yMax: yMaxGraph02),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          started
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 55,
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          disabledColor: Colors.grey,
                          color: Colors.orange,
                          onPressed: () {
                            blue.stop(widget.sc.device);
                            widget.updateStarted();
                            spotDataGraph01.clear();
                            spotDataGraph02.clear();
                            setState(() {
                              started = !started;
                            });
                          },
                          child: const Text(
                            'Stop',
                            style: TextStyle(
                                color: Color.fromARGB(255, 231, 230, 230),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 55,
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          disabledColor: Colors.grey,
                          color: Colors.green,
                          onPressed: () {
                            saveModeOne();
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                                color: Color.fromARGB(255, 231, 230, 230),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 55,
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          disabledColor: Colors.grey,
                          color: Colors.cyan,
                          onPressed: () {
                            if (widget.keyForm.currentState!.validate() &&
                                _formKey.currentState!.validate()) {
                              startMode4();
                            }
                          },
                          child: const Text(
                            'Start',
                            style: TextStyle(
                                color: Color.fromARGB(255, 231, 230, 230),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }

  void startMode4() {
    blue.runMode04(
        widget.sc.device,
        (double.parse(startingCurrentController.text) * 100).toInt(),
        (double.parse(desiredCurrentController.text) * 100).toInt(),
        (double.parse(maxVoltageController.text) * 10).toInt(),
        (double.parse(currentResolutionController.text) * 100).toInt(),
        (int.parse(changeInTimeController.text)));
    setState(() {
      started = !started;
    });

    setState(() {
      xMaxGraph01 = double.parse(desiredCurrentController.text);
      started = !started;
    });

    Timer.periodic(Duration(seconds: int.parse(changeInTimeController.text)),
        (Timer t) => setGraphValues());
    widget.updateStarted();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SizedBox(
      width: isLandscape ? (width / 3) * 2 - 32 : width,
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
                    children: [
                      const Text(
                        "Mode 04",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        "[service data  : ${ref.watch(ref.watch(deviceDataMap[widget.sc.device.name]!).streamData).notifyData}]",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
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
            )),
      ),
    );
  }
}
