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

class ConfigureRightPanelType03 extends ConsumerStatefulWidget {
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
  const ConfigureRightPanelType03(
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
  ConsumerState<ConfigureRightPanelType03> createState() =>
      _ConfigureRightPanelType03State();
}

class _ConfigureRightPanelType03State
    extends ConsumerState<ConfigureRightPanelType03> {
  Blue blue = Blue();
  final _formKey = GlobalKey<FormState>();

  void setGraphValues() {
    if (ref.watch(deviceDataMap[widget.sc.device.name]!).startedMode03) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
              .state ==
          6) {
        ref.read(deviceDataMap[widget.sc.device.name]!).startedMode03 = false;
      } else {
        if (ref
                .watch(
                    ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
                .currentProtocol ==
            3) {
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
          if (ref
                  .watch(deviceDataMap[widget.sc.device.name]!)
                  .xMaxGraph01Mode03 <
              currentReadingVoltage) {
            if (ref
                    .watch(deviceDataMap[widget.sc.device.name]!)
                    .yMaxGraph01Mode03 <
                currentReadingCurrent) {
              if (ref
                      .watch(deviceDataMap[widget.sc.device.name]!)
                      .yMaxGraph02Mode03 <
                  currentReadingTem) {
                ref
                    .read(deviceDataMap[widget.sc.device.name]!)
                    .yMaxGraph02Mode03 = currentReadingTem.toDouble();
              }
              ref
                  .read(deviceDataMap[widget.sc.device.name]!)
                  .xMaxGraph01Mode03 = currentReadingVoltage;
              ref
                  .read(deviceDataMap[widget.sc.device.name]!)
                  .yMaxGraph01Mode03 = currentReadingCurrent;
            } else {
              ref
                  .read(deviceDataMap[widget.sc.device.name]!)
                  .xMaxGraph01Mode03 = currentReadingVoltage;
            }
          } else {
            if (ref
                    .watch(deviceDataMap[widget.sc.device.name]!)
                    .yMaxGraph01Mode03 <
                currentReadingCurrent) {
              ref
                  .read(deviceDataMap[widget.sc.device.name]!)
                  .yMaxGraph01Mode03 = currentReadingCurrent;
            }
          }

          ref
              .watch(deviceDataMap[widget.sc.device.name]!)
              .spotDataGraph01Mode03
              .add(FlSpot(currentReadingVoltage, currentReadingCurrent));
          ref
              .watch(deviceDataMap[widget.sc.device.name]!)
              .spotDataGraph02Mode03
              .add(FlSpot(currentReadingVoltage, currentReadingTem.toDouble()));
        }
      }
    }
  }

  void saveModeOne() {
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
                        controller: ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .startingVoltageControllerMode03,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Starting voltage cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1})?$")
                              .hasMatch(val)) {
                            return "Starting voltage ONLY allowed one Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Starting voltage (V)',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .startedMode03)),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: TextInput(
                    data: TestInputData(
                        inputType: TextInputType.number,
                        controller: ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .desiredVoltageControllerMode03,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Desired Voltage cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1})?$")
                              .hasMatch(val)) {
                            return "Desired Voltage ONLY allowed one Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Desired Voltage (V)',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .startedMode03)),
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
                        controller: ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .maxCurrentControllerMode03,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Max Current cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,2})?$")
                              .hasMatch(val)) {
                            return "Max Current ONLY allowed two Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Max Current (A)',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .startedMode03)),
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
                        controller: ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .voltageResolutionControllerMode03,
                        inputType: TextInputType.number,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Voltage resolution cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1})?$")
                              .hasMatch(val)) {
                            return "Voltage resolution ONLY allowed one Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Voltage resolution',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .startedMode03)),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: TextInput(
                    data: TestInputData(
                        inputType: TextInputType.number,
                        controller: ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .changeInTimeControllerMode03,
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
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .startedMode03)),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ref.watch(deviceDataMap[widget.sc.device.name]!).startedMode03
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Voltage",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .spotDataGraph01Mode03,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .xMaxGraph01Mode03,
                              yAxisName: "Current",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .yMaxGraph01Mode03),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 10,
          ),
          ref.watch(deviceDataMap[widget.sc.device.name]!).startedMode03
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Voltage",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .spotDataGraph02Mode03,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .xMaxGraph01Mode03,
                              yAxisName: "Temperature",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .yMaxGraph02Mode03),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          ref.watch(deviceDataMap[widget.sc.device.name]!).startedMode03
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
                            ref
                                .watch(deviceDataMap[widget.sc.device.name]!)
                                .spotDataGraph01Mode03
                                .clear();
                            ref
                                .watch(deviceDataMap[widget.sc.device.name]!)
                                .spotDataGraph02Mode03
                                .clear();
                            ref
                                    .read(deviceDataMap[widget.sc.device.name]!)
                                    .startedMode03 =
                                !ref
                                    .watch(
                                        deviceDataMap[widget.sc.device.name]!)
                                    .startedMode03;
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
                              startMode3();
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

  void startMode3() {
    double startingVoltage = double.parse(ref
        .watch(deviceDataMap[widget.sc.device.name]!)
        .startingVoltageControllerMode03
        .text);
    double pointSize = double.parse(ref
        .watch(deviceDataMap[widget.sc.device.name]!)
        .voltageResolutionControllerMode03
        .text);

    blue.runMode03(
        widget.sc.device,
        (startingVoltage * 10).toInt(),
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.name]!)
                    .desiredVoltageControllerMode03
                    .text) *
                10)
            .toInt(),
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.name]!)
                    .maxCurrentControllerMode03
                    .text) *
                100)
            .toInt(),
        (pointSize * 10).toInt(),
        (int.parse(ref
            .watch(deviceDataMap[widget.sc.device.name]!)
            .changeInTimeControllerMode03
            .text)));

    ref.read(deviceDataMap[widget.sc.device.name]!).xMaxGraph01Mode03 =
        double.parse(ref
            .watch(deviceDataMap[widget.sc.device.name]!)
            .desiredVoltageControllerMode03
            .text);
    ref.read(deviceDataMap[widget.sc.device.name]!).startedMode03 =
        !ref.watch(deviceDataMap[widget.sc.device.name]!).startedMode03;

    Timer.periodic(
        Duration(
            seconds: int.parse(ref
                .watch(deviceDataMap[widget.sc.device.name]!)
                .changeInTimeControllerMode03
                .text)),
        (Timer t) => {
              setGraphValues(),
              if (!ref
                  .watch(deviceDataMap[widget.sc.device.name]!)
                  .startedMode03)
                {t.cancel()}
            });
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
                        "Mode 03",
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
