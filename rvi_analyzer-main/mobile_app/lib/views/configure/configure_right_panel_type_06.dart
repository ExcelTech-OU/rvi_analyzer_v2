import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';
import 'package:rvi_analyzer/repository/login_repo.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/service/mode_service.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';
import 'package:rvi_analyzer/views/common/line_chart.dart';
import 'package:rvi_analyzer/views/common/line_chart_temp.dart';
import 'package:rvi_analyzer/views/common/snack_bar.dart';
import 'package:rvi_analyzer/service/common_service.dart';
import 'package:rvi_analyzer/views/configure/mode_setting.dart';

class ConfigureRightPanelType06 extends ConsumerStatefulWidget {
  final ScanResult sc;
  final GlobalKey<FormState> keyForm;
  final void Function() updateTestId;
  const ConfigureRightPanelType06({
    Key? key,
    required this.sc,
    required this.keyForm,
    required this.updateTestId,
  }) : super(key: key);

  @override
  ConsumerState<ConfigureRightPanelType06> createState() =>
      _ConfigureRightPanelType06State();
}

class _ConfigureRightPanelType06State
    extends ConsumerState<ConfigureRightPanelType06> {
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
              6) {
            double currentReadingVoltage = ref
                .read(
                    ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
                .voltage;
            double currentReadingCurrent = ref
                .read(
                    ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
                .current;

            double currentReadingRes = currentReadingVoltage == 0
                ? 0.001 / currentReadingCurrent == 0
                    ? 0.001
                    : double.parse(ref
                        .read(deviceDataMap[widget.sc.device.id.id]!)
                        .fixedCurrentControllerMode06
                        .text)
                : currentReadingVoltage / currentReadingCurrent == 0
                    ? 0.001
                    : double.parse(ref
                        .read(deviceDataMap[widget.sc.device.id.id]!)
                        .fixedCurrentControllerMode06
                        .text);
            int currentReadingTem = ref
                .read(
                    ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
                .temperature;

            ref.read(deviceDataMap[widget.sc.device.id.id]!).timeMode06 =
                ref.read(deviceDataMap[widget.sc.device.id.id]!).timeMode06 + 1;

            double time =
                ref.read(deviceDataMap[widget.sc.device.id.id]!).timeMode06;

            //Update when x axis value groth
            if (ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .xMaxGraph01Mode06 <
                time) {
              if (ref
                      .watch(deviceDataMap[widget.sc.device.id.id]!)
                      .yMaxGraph01Mode06 <
                  currentReadingVoltage) {
                //Tem
                if (ref
                        .watch(deviceDataMap[widget.sc.device.id.id]!)
                        .yMaxGraph02Mode06 <
                    currentReadingTem) {
                  ref
                      .read(deviceDataMap[widget.sc.device.id.id]!)
                      .yMaxGraph02Mode06 = currentReadingTem.toDouble();
                }

                if (ref
                        .watch(deviceDataMap[widget.sc.device.id.id]!)
                        .yMaxGraph03Mode06 <
                    currentReadingRes) {
                  ref
                      .read(deviceDataMap[widget.sc.device.id.id]!)
                      .yMaxGraph02Mode06 = currentReadingRes;
                }

                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .xMaxGraph01Mode06 = ref
                        .read(deviceDataMap[widget.sc.device.id.id]!)
                        .xMaxGraph01Mode06 +
                    10;
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .yMaxGraph01Mode06 = currentReadingVoltage;
              } else {
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .xMaxGraph01Mode06 = ref
                        .read(deviceDataMap[widget.sc.device.id.id]!)
                        .xMaxGraph01Mode06 +
                    10;
              }
            } else {
              if (ref
                      .watch(deviceDataMap[widget.sc.device.id.id]!)
                      .yMaxGraph01Mode06 <
                  currentReadingVoltage) {
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .yMaxGraph01Mode06 = currentReadingVoltage;
              }
              if (ref
                      .watch(deviceDataMap[widget.sc.device.id.id]!)
                      .yMaxGraph02Mode06 <
                  currentReadingTem) {
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .yMaxGraph02Mode06 = currentReadingTem.toDouble();
              }

              if (ref
                      .watch(deviceDataMap[widget.sc.device.id.id]!)
                      .yMaxGraph03Mode06 <
                  currentReadingRes) {
                ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .yMaxGraph02Mode06 = currentReadingRes;
              }
            }

            ref
                .watch(deviceDataMap[widget.sc.device.id.id]!)
                .spotDataGraph01Mode06
                .add(FlSpot(time, currentReadingVoltage));
            ref
                .watch(deviceDataMap[widget.sc.device.id.id]!)
                .spotDataGraph02Mode06
                .add(FlSpot(time, currentReadingTem.toDouble()));
            ref
                .watch(deviceDataMap[widget.sc.device.id.id]!)
                .spotDataGraph03Mode06
                .add(FlSpot(time, currentReadingRes));
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

  Future<void> saveMode() async {
    ref.read(deviceDataMap[widget.sc.device.id.id]!).saveClickedMode06 = true;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).updateStatus();

    List<Reading> readings = [];

    List<FlSpot> voltageTimeReadings =
        ref.read(deviceDataMap[widget.sc.device.id.id]!).spotDataGraph01Mode06;

    List<FlSpot> temTimeReadings =
        ref.read(deviceDataMap[widget.sc.device.id.id]!).spotDataGraph02Mode06;

    List<FlSpot> resTimeReadings =
        ref.read(deviceDataMap[widget.sc.device.id.id]!).spotDataGraph03Mode06;

    for (var i = 0; i < voltageTimeReadings.length; i++) {
      readings.add(Reading(
          temperature: temTimeReadings[i].y.toString(),
          current: (voltageTimeReadings[i].y / resTimeReadings[i].y).toString(),
          voltage: voltageTimeReadings[i].y.toString()));
    }

    final loginInfoRepo = LoginInfoRepository();

    List<LoginInfo> infos = await loginInfoRepo.getAllLoginInfos();

    ModeSix modeSix = ModeSix(
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
        sessionConfigurationModeSix: SessionConfigurationModeSix(
            fixedCurrent: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .fixedCurrentControllerMode06
                .text,
            maxVoltage: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .maxVoltageControllerMode06
                .text,
            timeDuration: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .timeDurationControllerMode06
                .text),
        results: SessionResult(
            testId: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .testIdController
                .text,
            readings: readings),
        status: "ACTIVE");

    saveModeSix(modeSix, infos.first.username)
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
                    ..showSnackBar(getSnackBar(context, Colors.red,
                        "Remote submit failed. Check internet connection"))
                },
              ref
                  .read(deviceDataMap[widget.sc.device.id.id]!)
                  .saveClickedMode06 = false
            })
        .onError((error, stackTrace) => {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(getSnackBar(context, Colors.red,
                    "Remote submit failed. Check internet connection")),
              ref
                  .read(deviceDataMap[widget.sc.device.id.id]!)
                  .saveClickedMode06 = false
            });
    widget.updateTestId();
  }

  void resetGraph() {
    ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .spotDataGraph01Mode06
        .clear();
    ref
        .watch(deviceDataMap[widget.sc.device.id.id]!)
        .spotDataGraph02Mode06
        .clear();

    ref.read(deviceDataMap[widget.sc.device.id.id]!).xMaxGraph01Mode06 = 0.0;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph01Mode06 = 0.0;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph02Mode06 = 0.0;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).yMaxGraph03Mode06 = 0.0;
    ref.read(deviceDataMap[widget.sc.device.id.id]!).timeMode06 = 0;
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
                            .fixedCurrentControllerMode06,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Fixed Current cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,2})?$")
                              .hasMatch(val)) {
                            return "Fixed current ONLY allowed one Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Fixed Current (A)',
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
                            .maxVoltageControllerMode06,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Max Voltage cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,2})?$")
                              .hasMatch(val)) {
                            return "Max Voltage ONLY allowed two Place Value";
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
                        inputType: TextInputType.number,
                        controller: ref
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .timeDurationControllerMode06,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Time Duration cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers without decimal point";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Time Duration (Sec)',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .started)),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          !closed
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Time (Sec)",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .spotDataGraph01Mode06,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .xMaxGraph01Mode06,
                              yAxisName: "Voltage",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .yMaxGraph01Mode06),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          !closed
              ? const SizedBox(
                  height: 20,
                )
              : const SizedBox.shrink(),
          !closed
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Time (Sec)",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .spotDataGraph03Mode06,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .xMaxGraph01Mode06,
                              yAxisName: "Resistance",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .yMaxGraph03Mode06),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          !closed
              ? const SizedBox(
                  height: 20,
                )
              : const SizedBox.shrink(),
          !closed
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSampleTemp(
                          data: LineChartDataCustom2(
                              xAxisName: "Time (Sec)",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .spotDataGraph02Mode06,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .xMaxGraph01Mode06,
                              yAxisName: "Temperature",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .yMaxGraph02Mode06),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
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
                                  .saveClickedMode06
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
                                      .saveClickedMode06 ||
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
                                  .saveClickedMode06
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
                                    startMode6();
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

  void startMode6() {
    blue.runMode06(
        widget.sc.device,
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .fixedCurrentControllerMode06
                    .text) *
                100)
            .toInt(),
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .maxVoltageControllerMode06
                    .text) *
                10)
            .toInt(),
        double.parse(ref
                .watch(deviceDataMap[widget.sc.device.id.id]!)
                .timeDurationControllerMode06
                .text)
            .toInt());

    ref.read(deviceDataMap[widget.sc.device.id.id]!).started =
        !ref.watch(deviceDataMap[widget.sc.device.id.id]!).started;

    ref.read(deviceDataMap[widget.sc.device.id.id]!).updateStatus();

    Timer.periodic(
        const Duration(seconds: 1),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Mode 06",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
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
      ),
    );
  }
}
