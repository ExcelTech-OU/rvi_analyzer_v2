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

  void setGraphValues() {
    if (ref.watch(deviceDataMap[widget.sc.device.name]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
              .state ==
          6) {
        ref.read(deviceDataMap[widget.sc.device.name]!).started = false;
      } else {
        if (ref
                .watch(
                    ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
                .currentProtocol ==
            6) {
          double currentReadingVoltage = ref
              .read(ref.read(deviceDataMap[widget.sc.device.name]!).streamData)
              .voltage;
          double currentReadingCurrent = ref
              .read(ref.read(deviceDataMap[widget.sc.device.name]!).streamData)
              .current;

          double currentReadingRes =
              currentReadingVoltage / currentReadingCurrent;
          int currentReadingTem = ref
              .read(ref.read(deviceDataMap[widget.sc.device.name]!).streamData)
              .temperature;

          ref.read(deviceDataMap[widget.sc.device.name]!).timeMode06 =
              ref.read(deviceDataMap[widget.sc.device.name]!).timeMode06 + 1;

          double time =
              ref.read(deviceDataMap[widget.sc.device.name]!).timeMode06;

          //Update when x axis value groth
          if (ref
                  .watch(deviceDataMap[widget.sc.device.name]!)
                  .xMaxGraph01Mode06 <
              time) {
            if (ref
                    .watch(deviceDataMap[widget.sc.device.name]!)
                    .yMaxGraph01Mode06 <
                currentReadingVoltage) {
              //Tem
              if (ref
                      .watch(deviceDataMap[widget.sc.device.name]!)
                      .yMaxGraph02Mode06 <
                  currentReadingTem) {
                ref
                    .read(deviceDataMap[widget.sc.device.name]!)
                    .yMaxGraph02Mode06 = currentReadingTem.toDouble();
              }

              if (ref
                      .watch(deviceDataMap[widget.sc.device.name]!)
                      .yMaxGraph03Mode06 <
                  currentReadingRes) {
                ref
                    .read(deviceDataMap[widget.sc.device.name]!)
                    .yMaxGraph02Mode06 = currentReadingRes;
              }

              ref
                  .read(deviceDataMap[widget.sc.device.name]!)
                  .xMaxGraph01Mode06 = ref
                      .read(deviceDataMap[widget.sc.device.name]!)
                      .xMaxGraph01Mode06 +
                  10;
              ref
                  .read(deviceDataMap[widget.sc.device.name]!)
                  .yMaxGraph01Mode06 = currentReadingVoltage;
            } else {
              ref
                  .read(deviceDataMap[widget.sc.device.name]!)
                  .xMaxGraph01Mode06 = ref
                      .read(deviceDataMap[widget.sc.device.name]!)
                      .xMaxGraph01Mode06 +
                  10;
            }
          } else {
            if (ref
                    .watch(deviceDataMap[widget.sc.device.name]!)
                    .yMaxGraph01Mode06 <
                currentReadingVoltage) {
              ref
                  .read(deviceDataMap[widget.sc.device.name]!)
                  .yMaxGraph01Mode06 = currentReadingVoltage;
            }
          }

          ref
              .watch(deviceDataMap[widget.sc.device.name]!)
              .spotDataGraph01Mode06
              .add(FlSpot(time, currentReadingVoltage));
          ref
              .watch(deviceDataMap[widget.sc.device.name]!)
              .spotDataGraph02Mode06
              .add(FlSpot(time, currentReadingTem.toDouble()));
          ref
              .watch(deviceDataMap[widget.sc.device.name]!)
              .spotDataGraph03Mode06
              .add(FlSpot(time, currentReadingRes));
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
                        controller: ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
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
                            .watch(deviceDataMap[widget.sc.device.name]!)
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
                            .watch(deviceDataMap[widget.sc.device.name]!)
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
                            .watch(deviceDataMap[widget.sc.device.name]!)
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
                            .watch(deviceDataMap[widget.sc.device.name]!)
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
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .started)),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          ref.watch(deviceDataMap[widget.sc.device.name]!).started
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Current",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .spotDataGraph01Mode06,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .xMaxGraph01Mode06,
                              yAxisName: "Voltage",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .yMaxGraph01Mode06),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          ref.watch(deviceDataMap[widget.sc.device.name]!).started
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Time (Sec)",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .spotDataGraph01Mode06,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .xMaxGraph01Mode06,
                              yAxisName: "Voltage",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .yMaxGraph01Mode06),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 20,
          ),
          ref.watch(deviceDataMap[widget.sc.device.name]!).started
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Time (Sec)",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .spotDataGraph03Mode06,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .xMaxGraph01Mode06,
                              yAxisName: "Resistance",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .yMaxGraph03Mode06),
                        )),
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 20,
          ),
          ref.watch(deviceDataMap[widget.sc.device.name]!).started
              ? Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: LineChartSample2(
                          data: LineChartDataCustom(
                              xAxisName: "Time (Sec)",
                              spotData: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .spotDataGraph02Mode06,
                              xMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .xMaxGraph01Mode06,
                              yAxisName: "Temperature",
                              yMax: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
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
          ref.watch(deviceDataMap[widget.sc.device.name]!).started
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
                            ref
                                .watch(deviceDataMap[widget.sc.device.name]!)
                                .spotDataGraph01Mode06
                                .clear();
                            ref
                                .watch(deviceDataMap[widget.sc.device.name]!)
                                .spotDataGraph02Mode06
                                .clear();

                            ref
                                .read(deviceDataMap[widget.sc.device.name]!)
                                .xMaxGraph01Mode06 = 0.0;
                            ref
                                .read(deviceDataMap[widget.sc.device.name]!)
                                .yMaxGraph01Mode06 = 0.2;
                            ref
                                .read(deviceDataMap[widget.sc.device.name]!)
                                .yMaxGraph02Mode06 = 0.0;
                            ref
                                .read(deviceDataMap[widget.sc.device.name]!)
                                .yMaxGraph03Mode06 = 0.0;
                            ref
                                .read(deviceDataMap[widget.sc.device.name]!)
                                .timeMode06 = 0;

                            ref
                                    .read(deviceDataMap[widget.sc.device.name]!)
                                    .started =
                                !ref
                                    .watch(
                                        deviceDataMap[widget.sc.device.name]!)
                                    .started;

                            ref
                                .read(deviceDataMap[widget.sc.device.name]!)
                                .updateStatus();
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
                              startMode6();
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

  void startMode6() {
    blue.runMode06(
        widget.sc.device,
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.name]!)
                    .fixedCurrentControllerMode06
                    .text) *
                100)
            .toInt(),
        (double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.name]!)
                    .maxVoltageControllerMode06
                    .text) *
                10)
            .toInt(),
        double.parse(ref
                .watch(deviceDataMap[widget.sc.device.name]!)
                .timeDurationControllerMode06
                .text)
            .toInt());

    ref.read(deviceDataMap[widget.sc.device.name]!).started =
        !ref.watch(deviceDataMap[widget.sc.device.name]!).started;

    ref.read(deviceDataMap[widget.sc.device.name]!).updateStatus();

    Timer.periodic(const Duration(seconds: 1), (Timer t) => setGraphValues());
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
                        "Mode 06",
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
