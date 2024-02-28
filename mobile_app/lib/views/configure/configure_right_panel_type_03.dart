import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';
import 'package:rvi_analyzer/repository/login_repo.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/service/mode_service.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';
import 'package:rvi_analyzer/views/common/line_chart.dart';
import 'package:rvi_analyzer/views/common/line_chart_temp.dart';
import 'package:rvi_analyzer/views/common/snack_bar.dart';
import 'package:rvi_analyzer/service/common_service.dart';

class ConfigureRightPanelType03 extends ConsumerStatefulWidget {
  final ScanResult sc;
  final GlobalKey<FormState> keyForm;
  final void Function() updateTestId;
  const ConfigureRightPanelType03(
      {Key? key,
      required this.sc,
      required this.keyForm,
      required this.updateTestId})
      : super(key: key);

  @override
  ConsumerState<ConfigureRightPanelType03> createState() =>
      _ConfigureRightPanelType03State();
}

class _ConfigureRightPanelType03State
    extends ConsumerState<ConfigureRightPanelType03> {
  Blue blue = Blue();
  final _formKey = GlobalKey<FormState>();
  int startTimer = 0;
  bool statusChanged = false;
  int currentStatus = 6;

  bool forceStopped = false;
  bool closed = true;
  bool dataSavedSuccess = false;
  bool stopClicked = false;

  bool isNeedToShowGraph() {
    return !closed;
  }

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
          setState(() {
            // closed = true;
            currentStatus = 6;
            statusChanged = false;
            startTimer = 0;
          });
          ref.read(deviceDataMap[widget.sc.device.id.id]!).started = false;
          ref.read(deviceDataMap[widget.sc.device.id.id]!).updateStatus();
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
              3) {
            if (double.parse(ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .startingVoltageControllerMode03
                    .text) <
                double.parse(ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .desiredVoltageControllerMode03
                    .text)) {
              incrementDataGraph();
            } else {
              decrementDataGraph();
            }
          }
        }
      }
    }
  }

  void decrementDataGraph() {
    ref.read(deviceDataMap[widget.sc.device.id.id]!).xMaxGraph01Mode03 =
        double.parse(ref
            .read(deviceDataMap[widget.sc.device.id.id]!)
            .desiredVoltageControllerMode03
            .text);
    double currentReadingVoltage = ref
        .read(ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
        .voltage;
    double currentReadingCurrent = ref
        .read(ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
        .current;
    int currentReadingTem = ref
        .read(ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
        .temperature;

    //Update when x axis value groth
    if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).xMaxGraph01Mode03 >
        currentReadingVoltage) {
      if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode03 <
          currentReadingCurrent) {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode03 =
            currentReadingCurrent;
      }
      if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode03 <
          currentReadingTem) {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode03 =
            currentReadingTem.toDouble();
      }
    } else {
      if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode03 <
          currentReadingCurrent) {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode03 =
            currentReadingCurrent;
      }
      if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode03 <
          currentReadingTem) {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode03 =
            currentReadingTem.toDouble();
      }
    }

    ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .spotDataGraph01Mode03
        .add(FlSpot(currentReadingVoltage, currentReadingCurrent));
    ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .spotDataGraph02Mode03
        .add(FlSpot(currentReadingVoltage, currentReadingTem.toDouble()));
  }

  void incrementDataGraph() {
    double currentReadingVoltage = ref
        .read(ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
        .voltage;
    double currentReadingCurrent = ref
        .read(ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
        .current;
    int currentReadingTem = ref
        .read(ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
        .temperature;

    //Update when x axis value groth
    if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).xMaxGraph01Mode03 <
        currentReadingVoltage) {
      if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode03 <
          currentReadingCurrent) {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).xMaxGraph01Mode03 =
            currentReadingVoltage;
        ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode03 =
            currentReadingCurrent;
      } else {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).xMaxGraph01Mode03 =
            currentReadingVoltage;
      }
      if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode03 <
          currentReadingTem) {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode03 =
            currentReadingTem.toDouble();
      }
    } else {
      if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode03 <
          currentReadingCurrent) {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode03 =
            currentReadingCurrent;
      }
      if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode03 <
          currentReadingTem) {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode03 =
            currentReadingTem.toDouble();
      }
    }

    ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .spotDataGraph01Mode03
        .add(FlSpot(currentReadingVoltage, currentReadingCurrent));
    ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .spotDataGraph02Mode03
        .add(FlSpot(currentReadingVoltage, currentReadingTem.toDouble()));
  }

  void updateSessionID() {
    DateTime now = DateTime.now();
    int milliseconds = now.millisecondsSinceEpoch;

    ref.watch(deviceDataMap[widget.sc.device.id.id]!).sessionIdController.text =
        "S_$milliseconds";
  }

  Future<void> saveMode() async {
    ref.read(deviceDataMap[widget.sc.device.id.id]!).saveClickedMode03 = true;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).updateStatus();

    List<Reading> readings = [];

    List<FlSpot> currentVoltageReadings =
        ref.read(deviceDataMap[widget.sc.device.id.id]!).spotDataGraph01Mode03;

    List<FlSpot> temVoltageReadings =
        ref.read(deviceDataMap[widget.sc.device.id.id]!).spotDataGraph02Mode03;

    for (var i = 0; i < currentVoltageReadings.length; i++) {
      readings.add(Reading(
          temperature: temVoltageReadings[i].y.toString(),
          current: currentVoltageReadings[i].y.toString(),
          voltage: currentVoltageReadings[i].x.toString()));
    }

    final loginInfoRepo = LoginInfoRepository();

    List<LoginInfo> infos = await loginInfoRepo.getAllLoginInfos();

    ModeThree modeThree = ModeThree(
        createdBy: infos.first.username,
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
        sessionConfigurationModeThree: SessionConfigurationModeThree(
            startingVoltage: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .startingVoltageControllerMode03
                .text,
            desiredVoltage: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .desiredVoltageControllerMode03
                .text,
            maxCurrent: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .maxCurrentControllerMode03
                .text,
            voltageResolution: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .voltageResolutionControllerMode03
                .text,
            chargeInTime: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .changeInTimeControllerMode03
                .text),
        results: SessionResult(
            testId: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .testIdController
                .text,
            readings: readings),
        status: "ACTIVE");

    saveModeThree(modeThree, infos.first.username)
        .then((value) => {
              if (value.status == "S1000")
                {
                  setState(() {
                    dataSavedSuccess = true;
                  }),
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
                    ..showSnackBar(getSnackBar(context, Colors.red,
                        "Remote submit failed. Check internet connection"))
                },
              ref
                  .read(deviceDataMap[widget.sc.device.id.id]!)
                  .saveClickedMode03 = false,
              ref.read(deviceDataMap[widget.sc.device.id.id]!).updateStatus(),
            })
        .onError((error, stackTrace) => {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(getSnackBar(context, Colors.red,
                    "Remote submit failed. Check internet connection")),
              ref
                  .read(deviceDataMap[widget.sc.device.id.id]!)
                  .saveClickedMode03 = false,
              ref.read(deviceDataMap[widget.sc.device.id.id]!).updateStatus(),
            });
    updateSessionID();
    widget.updateTestId();
  }

  void resetGraph() {
    ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .spotDataGraph01Mode03
        .clear();
    ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .spotDataGraph02Mode03
        .clear();

    ref.read(deviceDataMap[widget.sc.device.id.id]!).xMaxGraph01Mode03 = 0.0;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode03 = 0.0;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode03 = 0.0;
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .started)),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          isNeedToShowGraph()
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xMin:
                                  double.parse(ref.read(deviceDataMap[widget.sc.device.id.id]!).startingVoltageControllerMode03.text) <
                                          double.parse(ref
                                              .read(deviceDataMap[
                                                  widget.sc.device.id.id]!)
                                              .desiredVoltageControllerMode03
                                              .text)
                                      ? 0
                                      : double.parse(ref
                                          .read(deviceDataMap[
                                              widget.sc.device.id.id]!)
                                          .startingVoltageControllerMode03
                                          .text),
                              xAxisName: "Voltage",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .spotDataGraph01Mode03,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .xMaxGraph01Mode03,
                              yAxisName: "Current",
                              yMax: ref.watch(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode03),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 10,
          ),
          isNeedToShowGraph()
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSampleTemp(
                          data: LineChartDataCustom2(
                              xMin:
                                  double.parse(ref.read(deviceDataMap[widget.sc.device.id.id]!).startingVoltageControllerMode03.text) <
                                          double.parse(ref
                                              .read(deviceDataMap[
                                                  widget.sc.device.id.id]!)
                                              .desiredVoltageControllerMode03
                                              .text)
                                      ? 0
                                      : double.parse(ref
                                          .read(deviceDataMap[
                                              widget.sc.device.id.id]!)
                                          .startingVoltageControllerMode03
                                          .text),
                              xAxisName: "Voltage",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .spotDataGraph02Mode03,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .xMaxGraph01Mode03,
                              yAxisName: "Temperature",
                              yMax: ref.watch(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode03),
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
                                  .saveClickedMode03
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
                                    setState(() {
                                      stopClicked = true;
                                    });
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
                                  }

                                  setState(() {
                                    currentStatus = 6;
                                    statusChanged = false;
                                    startTimer = 0;
                                    forceStopped = true;
                                  });
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
                                      .saveClickedMode03 ||
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
                                  .saveClickedMode03
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
                                    startMode3();
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

  void startMode3() {
    double startingVoltage = double.parse(ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .startingVoltageControllerMode03
        .text);
    double pointSize = double.parse(ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .voltageResolutionControllerMode03
        .text);

    blue.runMode03(
        widget.sc.device,
        (startingVoltage * 10).toInt(),
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .desiredVoltageControllerMode03
                    .text) *
                10)
            .toInt(),
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .maxCurrentControllerMode03
                    .text) *
                100)
            .toInt(),
        (pointSize * 10).toInt(),
        (int.parse(ref
            .watch(deviceDataMap[widget.sc.device.id.id]!)
            .changeInTimeControllerMode03
            .text)));

    ref.read(deviceDataMap[widget.sc.device.id.id]!).xMaxGraph01Mode03 =
        double.parse(ref
            .watch(deviceDataMap[widget.sc.device.id.id]!)
            .desiredVoltageControllerMode03
            .text);
    ref.read(deviceDataMap[widget.sc.device.id.id]!).started =
        !ref.watch(deviceDataMap[widget.sc.device.id.id]!).started;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).updateStatus();

    Timer.periodic(
        Duration(
            seconds: int.parse(ref
                .watch(deviceDataMap[widget.sc.device.id.id]!)
                .changeInTimeControllerMode03
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
                        "Mode 03",
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
