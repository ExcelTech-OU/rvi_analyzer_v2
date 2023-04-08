import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rvi_analyzer/domain/default_configuration.dart';
import 'package:rvi_analyzer/domain/mode_two.dart';
import 'package:rvi_analyzer/domain/session_result.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/service/mode_service.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';
import 'package:rvi_analyzer/views/configure/snack_bar.dart';
import 'package:rvi_analyzer/service/common_service.dart';

class ConfigureRightPanelType02 extends ConsumerStatefulWidget {
  final ScanResult sc;
  final GlobalKey<FormState> keyForm;
  final void Function() updateTestId;
  const ConfigureRightPanelType02(
      {Key? key,
      required this.sc,
      required this.keyForm,
      required this.updateTestId})
      : super(key: key);

  @override
  ConsumerState<ConfigureRightPanelType02> createState() =>
      _ConfigureRightPanelType02State();
}

class _ConfigureRightPanelType02State
    extends ConsumerState<ConfigureRightPanelType02> {
  Blue blue = Blue();
  final _formKey = GlobalKey<FormState>();

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
                        "Mode 02",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      // const SizedBox(
                      //   width: 50,
                      // ),
                      // Text(
                      //   "[service data  : ${ref.watch(ref.watch(deviceDataMap[widget.sc.device.name]!).streamData).notifyData}]",
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

  void updateSessionID() {
    DateTime now = DateTime.now();
    int milliseconds = now.millisecondsSinceEpoch;

    ref.watch(deviceDataMap[widget.sc.device.name]!).sessionIdController.text =
        "S_$milliseconds";
  }

  String getVoltage() {
    if (ref.watch(deviceDataMap[widget.sc.device.name]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
              .currentProtocol ==
          2) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
            .voltage
            .toString());
      }
    }
    return "00";
  }

  String getResistance() {
    if (ref.watch(deviceDataMap[widget.sc.device.name]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
              .currentProtocol ==
          2) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
            .resistance
            .toStringAsFixed(3));
      }
    }
    return "00";
  }

  String getCurrent() {
    if (ref.watch(deviceDataMap[widget.sc.device.name]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
              .currentProtocol ==
          1) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
            .current
            .toString());
      }
    }
    return "00";
  }

  String getTemp() {
    if (ref.watch(deviceDataMap[widget.sc.device.name]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
              .currentProtocol ==
          2) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
            .temperature
            .toString());
      }
    }
    return "00";
  }

  void saveMode() {
    double voltage = ref
        .read(ref.read(deviceDataMap[widget.sc.device.name]!).streamData)
        .voltage;
    ref.read(deviceDataMap[widget.sc.device.name]!).saveClickedMode02 = true;

    if (double.parse(ref
                .watch(deviceDataMap[widget.sc.device.name]!)
                .minVoltageRangeControllerMode02
                .text) <
            voltage &&
        voltage <
            double.parse(ref
                .watch(deviceDataMap[widget.sc.device.name]!)
                .maxVoltageRangeControllerMode02
                .text)) {
      ref.read(deviceDataMap[widget.sc.device.name]!).passedMode02 = true;
    } else {
      ref.read(deviceDataMap[widget.sc.device.name]!).passedMode02 = false;
    }

    ModeTwo modeTwo = ModeTwo(
        createdBy: "rukshan",
        defaultConfigurations: DefaultConfiguration(
            customerName: ref
                .read(deviceDataMap[widget.sc.device.name]!)
                .customerNameController
                .text,
            operatorId: ref
                .read(deviceDataMap[widget.sc.device.name]!)
                .operatorIdController
                .text,
            batchNo: ref
                .read(deviceDataMap[widget.sc.device.name]!)
                .batchNoController
                .text,
            sessionId: ref
                .read(deviceDataMap[widget.sc.device.name]!)
                .sessionIdController
                .text),
        sessionConfigurationModeTwo: SessionConfigurationModeTwo(
            current: ref
                .read(deviceDataMap[widget.sc.device.name]!)
                .currentControllerMode02
                .text,
            maxVoltage: ref
                .read(deviceDataMap[widget.sc.device.name]!)
                .maxVoltageControllerMode02
                .text,
            passMaxVoltage: ref
                .read(deviceDataMap[widget.sc.device.name]!)
                .maxVoltageRangeControllerMode02
                .text,
            passMinVoltage: ref
                .read(deviceDataMap[widget.sc.device.name]!)
                .minVoltageRangeControllerMode02
                .text),
        results: [
          SessionResult(
              testId: ref
                  .read(deviceDataMap[widget.sc.device.name]!)
                  .testIdController
                  .text,
              readings: [
                Reading(
                    temperature: getTemp(),
                    current: getCurrent(),
                    voltage: getVoltage(),
                    result: ref
                            .read(deviceDataMap[widget.sc.device.name]!)
                            .passedMode02
                        ? "PASS"
                        : "FAIL",
                    readAt:
                        DateTime.now().toUtc().toString().replaceAll(" ", "T"))
              ])
        ],
        status: "ACTIVE");

    saveModeTwo(modeTwo)
        .then((value) => {
              if (value.status == "S1000")
                {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(getSnackBar(
                        ContentType.success,
                        "Date saved successfully with test id ${ref.read(deviceDataMap[widget.sc.device.name]!).testIdController.text}",
                        "Saving Success"))
                }
              else if (value.status == "E2000")
                {showLogoutPopup(context)}
              else
                {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(getSnackBar(
                        ContentType.failure,
                        "Data save failed with test id ${ref.read(deviceDataMap[widget.sc.device.name]!).testIdController.text}",
                        "Saving Failed"))
                },
              ref
                  .read(deviceDataMap[widget.sc.device.name]!)
                  .saveClickedMode02 = false
            })
        .onError((error, stackTrace) => {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(getSnackBar(
                    ContentType.failure,
                    "Data save failed with test id ${ref.read(deviceDataMap[widget.sc.device.name]!).testIdController.text}",
                    "Saving Failed"))
            });

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
                            .currentControllerMode02,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Current cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,2})?$")
                              .hasMatch(val)) {
                            return "Current ONLY allowed two Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Current (A)',
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
                            .maxVoltageControllerMode02,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Max Voltage cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1})?$")
                              .hasMatch(val)) {
                            return "Max Voltage ONLY allowed one Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Max voltage (V)',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .started)),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Voltage Range : ',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextInput(
                    data: TestInputData(
                        controller: ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .minVoltageRangeControllerMode02,
                        inputType: TextInputType.number,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Min Voltage cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1})?$")
                              .hasMatch(val)) {
                            return "Max Voltage ONLY allowed one Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Min (V)')),
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
                            .maxVoltageRangeControllerMode02,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Max Voltage cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1})?$")
                              .hasMatch(val)) {
                            return "Max Voltage ONLY allowed one Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Max (V)')),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Current Readings : ',
            style: TextStyle(fontSize: 15, color: Colors.grey),
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
                            .currentReadingCurrentControllerMode02,
                        inputType: TextInputType.number,
                        enabled: false,
                        validatorFun: (val) {
                          null;
                        },
                        labelText: 'Voltage : ${getVoltage()} V')),
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
                            .currentReadingTemControllerMode02,
                        enabled: false,
                        validatorFun: (val) {
                          null;
                        },
                        labelText: 'Temp : ${getTemp()} \u2103')),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextInput(
              data: TestInputData(
                  controller: ref
                      .watch(deviceDataMap[widget.sc.device.name]!)
                      .currentReadingResistanceControllerMode02,
                  enabled: false,
                  validatorFun: (val) {
                    null;
                  },
                  labelText: 'Resistance : ${getResistance()} \u2126')),
          const SizedBox(
            height: 10,
          ),
          ref.watch(deviceDataMap[widget.sc.device.name]!).started &&
                  ref
                      .watch(deviceDataMap[widget.sc.device.name]!)
                      .saveClickedMode02
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 55,
                        child: CupertinoButton(
                          disabledColor: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .passedMode02
                              ? Colors.green
                              : Colors.red,
                          color: Colors.cyan,
                          onPressed: null,
                          child: Text(
                            ref
                                    .watch(
                                        deviceDataMap[widget.sc.device.name]!)
                                    .passedMode02
                                ? 'PASS'
                                : 'FAIL',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 231, 230, 230),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 15,
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
                          onPressed: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .saveClickedMode02
                              ? null
                              : () {
                                  blue.stop(widget.sc.device);
                                  ref
                                          .read(deviceDataMap[
                                              widget.sc.device.name]!)
                                          .started =
                                      !ref
                                          .watch(deviceDataMap[
                                              widget.sc.device.name]!)
                                          .started;
                                  ref
                                      .read(
                                          deviceDataMap[widget.sc.device.name]!)
                                      .updateStatus();
                                  updateSessionID();
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
                          onPressed: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .saveClickedMode02
                              ? null
                              : () {
                                  saveMode();
                                },
                          child: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .saveClickedMode02
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
                          onPressed: () {
                            if (widget.keyForm.currentState!.validate() &&
                                _formKey.currentState!.validate()) {
                              blue.runMode02(
                                  widget.sc.device,
                                  (double.parse(ref
                                              .watch(deviceDataMap[
                                                  widget.sc.device.name]!)
                                              .currentControllerMode02
                                              .text) *
                                          100)
                                      .toInt(),
                                  (double.parse(ref
                                              .watch(deviceDataMap[
                                                  widget.sc.device.name]!)
                                              .maxVoltageControllerMode02
                                              .text) *
                                          10)
                                      .toInt());
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
}
