import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rvi_analyzer/domain/default_configuration.dart';
import 'package:rvi_analyzer/domain/mode_four.dart';
import 'package:rvi_analyzer/domain/session_result.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/service/mode_service.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';
import 'package:rvi_analyzer/views/common/line_chart.dart';
import 'package:rvi_analyzer/views/common/line_chart_temp.dart';
import 'package:rvi_analyzer/views/common/snack_bar.dart';
import 'package:rvi_analyzer/service/common_service.dart';

class ConfigureRightPanelType04 extends ConsumerStatefulWidget {
  final ScanResult sc;
  final GlobalKey<FormState> keyForm;
  final void Function() updateTestId;
  const ConfigureRightPanelType04({
    Key? key,
    required this.sc,
    required this.keyForm,
    required this.updateTestId,
  }) : super(key: key);

  @override
  ConsumerState<ConfigureRightPanelType04> createState() =>
      _ConfigureRightPanelType04State();
}

class _ConfigureRightPanelType04State
    extends ConsumerState<ConfigureRightPanelType04> {
  Blue blue = Blue();
  final _formKey = GlobalKey<FormState>();
  int startTimer = 0;
  bool statusChanged = false;
  int currentStatus = 6;

  bool forceStopped = false;
  bool closed = true;
  bool dataSavedSuccess = false;
  bool stopClicked = false;

  void setGraphValues() {
    if (currentStatus == 6 && !statusChanged) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
              .state ==
          3) {
        setState(() {
          closed = false;
          statusChanged = true;
          currentStatus = 3;
        });
      } else {
        setState(() {
          startTimer++;
        });
      }
    } else {
      if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).started) {
        if (ref
                .watch(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .streamData)
                .state ==
            6) {
          ref.read(deviceDataMap[widget.sc.device.id.id]!).started = false;

          setState(() {
            currentStatus = 6;
            statusChanged = false;
            startTimer = 0;
          });
        } else {
          setState(() {
            closed = false;
            currentStatus = 3;
            statusChanged = true;
            startTimer = 0;
            dataSavedSuccess = false;
          });
          if (ref
                  .watch(ref
                      .watch(deviceDataMap[widget.sc.device.id.id]!)
                      .streamData)
                  .currentProtocol ==
              4) {
            double currentReadingVoltage = ref
                .read(
                    ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
                .voltage;
            double currentReadingCurrent = ref
                .read(
                    ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
                .current;
            int currentReadingTem = ref
                .watch(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .streamData)
                .temperature;

            //Update when x axis value groth
            if (ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .xMaxGraph01Mode04 <
                currentReadingCurrent) {
              if (ref
                      .watch(deviceDataMap[widget.sc.device.id.id]!)
                      .yMaxGraph01Mode04 <
                  currentReadingVoltage) {
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .xMaxGraph01Mode04 = currentReadingCurrent;
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .yMaxGraph01Mode04 = currentReadingVoltage;
              } else {
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .xMaxGraph01Mode04 = currentReadingCurrent;
              }
              if (ref
                      .watch(deviceDataMap[widget.sc.device.id.id]!)
                      .yMaxGraph02Mode04 <
                  currentReadingTem.toDouble()) {
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .yMaxGraph02Mode04 = currentReadingTem.toDouble();
              }
            } else {
              if (ref
                      .watch(deviceDataMap[widget.sc.device.id.id]!)
                      .yMaxGraph01Mode04 <
                  currentReadingVoltage) {
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .yMaxGraph01Mode04 = currentReadingVoltage;
              }
              if (ref
                      .watch(deviceDataMap[widget.sc.device.id.id]!)
                      .yMaxGraph02Mode04 <
                  currentReadingTem.toDouble()) {
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .yMaxGraph02Mode04 = currentReadingTem.toDouble();
              }
            }

            ref
                .watch(deviceDataMap[widget.sc.device.id.id]!)
                .spotDataGraph01Mode04
                .add(FlSpot(currentReadingCurrent, currentReadingVoltage));
            ref
                .watch(deviceDataMap[widget.sc.device.id.id]!)
                .spotDataGraph02Mode04
                .add(FlSpot(
                    currentReadingCurrent, currentReadingTem.toDouble()));
          }
        }
      }
    }
  }

  void updateSessionID() {
    DateTime now = DateTime.now();
    int milliseconds = now.millisecondsSinceEpoch;

    ref.watch(deviceDataMap[widget.sc.device.id.id]!).sessionIdController.text =
        "S_$milliseconds";
  }

  void saveMode() {
    ref.read(deviceDataMap[widget.sc.device.id.id]!).saveClickedMode04 = true;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).updateStatus();

    List<Reading> readings = [];

    List<FlSpot> voltageCurrentReadings =
        ref.read(deviceDataMap[widget.sc.device.id.id]!).spotDataGraph01Mode04;

    List<FlSpot> temCurrentReadings =
        ref.read(deviceDataMap[widget.sc.device.id.id]!).spotDataGraph02Mode04;

    for (var i = 0; i < voltageCurrentReadings.length; i++) {
      readings.add(Reading(
          temperature: temCurrentReadings[i].y.toString(),
          current: voltageCurrentReadings[i].x.toString(),
          voltage: voltageCurrentReadings[i].y.toString()));
    }

    ModeFour modeFour = ModeFour(
        createdBy: "rukshan",
        defaultConfigurations: DefaultConfiguration(
            customerName: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .customerNameController
                .text,
            operatorId: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .operatorIdController
                .text,
            serialNo: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .serialNoController
                .text,
            batchNo: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .batchNoController
                .text,
            sessionId: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .sessionIdController
                .text),
        sessionConfigurationModeFour: SessionConfigurationModeFour(
            startingCurrent: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .startingCurrentControllerMode04
                .text,
            desiredCurrent: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .desiredCurrentControllerMode04
                .text,
            maxVoltage: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .maxVoltageControllerMode04
                .text,
            currentResolution: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .currentResolutionControllerMode04
                .text,
            chargeInTime: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .changeInTimeControllerMode04
                .text),
        results: SessionResult(
            testId: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .testIdController
                .text,
            readings: readings),
        status: "ACTIVE");

    saveModeFour(modeFour)
        .then((value) => {
              if (value.status == "S1000")
                {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        getSnackBar(context, Colors.green, "Saving Success"))
                }
              else if (value.status == "E2000")
                {showLogoutPopup(context, ref)}
              else
                {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        getSnackBar(context, Colors.red, "Saving Failed"))
                },
              ref
                  .read(deviceDataMap[widget.sc.device.id.id]!)
                  .saveClickedMode04 = false
            })
        .onError((error, stackTrace) => {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    getSnackBar(context, Colors.red, "Saving Failed"))
            });
    widget.updateTestId();
  }

  void resetGraph() {
    ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .spotDataGraph01Mode04
        .clear();
    ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .spotDataGraph02Mode04
        .clear();

    ref.read(deviceDataMap[widget.sc.device.id.id]!).xMaxGraph01Mode04 = 0.0;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode04 = 0.0;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode04 = 0.0;
    updateSessionID();
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .startingCurrentControllerMode04,
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
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .started)),
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .desiredCurrentControllerMode04,
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
                        labelText: 'Desired Current (A)',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .started)),
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .maxVoltageControllerMode04,
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
                        labelText: 'Max Voltage (V)',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .started)),
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .currentResolutionControllerMode04,
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
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .started)),
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .changeInTimeControllerMode04,
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .started)),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          !closed
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Current",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .spotDataGraph01Mode04,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .xMaxGraph01Mode04,
                              yAxisName: "Voltage",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .yMaxGraph01Mode04),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 10,
          ),
          !closed
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSampleTemp(
                          data: LineChartDataCustom2(
                              xAxisName: "Current",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .spotDataGraph02Mode04,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .xMaxGraph01Mode04,
                              yAxisName: "Temperature",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .yMaxGraph02Mode04),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          !closed
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 55,
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          disabledColor: Colors.grey,
                          color: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .started
                              ? Colors.orange
                              : Colors.red,
                          onPressed: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .saveClickedMode04
                              ? null
                              : () {
                                  if (!ref
                                      .watch(deviceDataMap[
                                          widget.sc.device.id.id]!)
                                      .started) {
                                    resetGraph();
                                    setState(() {
                                      closed = true;
                                    });
                                  } else {
                                    blue
                                        .stop(widget.sc.device)
                                        .then((value) => {
                                              ref
                                                      .read(deviceDataMap[widget
                                                          .sc.device.id.id]!)
                                                      .started =
                                                  !ref
                                                      .watch(deviceDataMap[
                                                          widget.sc.device.id
                                                              .id]!)
                                                      .started,
                                              ref
                                                  .read(deviceDataMap[
                                                      widget.sc.device.id.id]!)
                                                  .updateStatus(),
                                              setState(() {
                                                stopClicked = false;
                                              }),
                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(getSnackBar(
                                                    context,
                                                    Colors.green,
                                                    "Stopping Success"))
                                            })
                                        .onError((error, stackTrace) => {
                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(getSnackBar(
                                                    context,
                                                    Colors.red,
                                                    "Stop Failed"))
                                            });
                                    setState(() {
                                      currentStatus = 6;
                                      statusChanged = false;
                                      startTimer = 0;
                                      forceStopped = true;
                                    });
                                  }
                                },
                          child: (ref
                                      .watch(deviceDataMap[
                                          widget.sc.device.id.id]!)
                                      .started &&
                                  stopClicked)
                              ? const SpinKitWave(
                                  color: Colors.white,
                                  size: 20.0,
                                )
                              : Text(
                                  ref
                                          .watch(deviceDataMap[
                                              widget.sc.device.id.id]!)
                                          .started
                                      ? 'Stop'
                                      : "Close",
                                  style: const TextStyle(
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
                          onPressed: ref
                                      .watch(deviceDataMap[
                                          widget.sc.device.id.id]!)
                                      .saveClickedMode04 ||
                                  ref
                                      .watch(deviceDataMap[
                                          widget.sc.device.id.id]!)
                                      .started ||
                                  dataSavedSuccess
                              ? null
                              : () {
                                  saveMode();
                                },
                          child: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .saveClickedMode04
                              ? const SpinKitWave(
                                  color: Colors.white,
                                  size: 20.0,
                                )
                              : const Text(
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
                          onPressed: ref
                                      .watch(deviceDataMap[
                                          widget.sc.device.id.id]!)
                                      .started &&
                                  !statusChanged
                              ? null
                              : () {
                                  if (widget.keyForm.currentState!.validate() &&
                                      _formKey.currentState!.validate()) {
                                    resetGraph();
                                    startMode4();
                                  }
                                },
                          child: ref
                                      .watch(deviceDataMap[
                                          widget.sc.device.id.id]!)
                                      .started &&
                                  !statusChanged
                              ? const SpinKitWave(
                                  color: Colors.white,
                                  size: 20.0,
                                )
                              : const Text(
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
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .startingCurrentControllerMode04
                    .text) *
                100)
            .toInt(),
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .desiredCurrentControllerMode04
                    .text) *
                100)
            .toInt(),
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .maxVoltageControllerMode04
                    .text) *
                10)
            .toInt(),
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .currentResolutionControllerMode04
                    .text) *
                100)
            .toInt(),
        (int.parse(ref
            .watch(deviceDataMap[widget.sc.device.id.id]!)
            .changeInTimeControllerMode04
            .text)));

    ref.read(deviceDataMap[widget.sc.device.id.id]!).xMaxGraph01Mode04 =
        double.parse(ref
            .watch(deviceDataMap[widget.sc.device.id.id]!)
            .desiredCurrentControllerMode04
            .text);
    ref.read(deviceDataMap[widget.sc.device.id.id]!).started =
        !ref.watch(deviceDataMap[widget.sc.device.id.id]!).started;

    ref.read(deviceDataMap[widget.sc.device.id.id]!).updateStatus();

    Timer.periodic(
        Duration(
            seconds: int.parse(ref
                .watch(deviceDataMap[widget.sc.device.id.id]!)
                .changeInTimeControllerMode04
                .text)),
        (Timer t) => {
              setGraphValues(),
              if (!ref.watch(deviceDataMap[widget.sc.device.id.id]!).started)
                {t.cancel()}
            });
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
                      // const SizedBox(
                      //   width: 50,
                      // ),
                      // Text(
                      //   "[service data  : ${ref.watch(ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData).notifyData}]",
                      //   style: const TextStyle(
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black54),
                      // ),
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
