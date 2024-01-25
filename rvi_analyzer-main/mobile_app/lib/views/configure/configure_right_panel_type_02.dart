import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';
import 'package:rvi_analyzer/repository/login_repo.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/service/mode_service.dart';
import 'package:rvi_analyzer/views/common/form_eliments/dropdown.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';
import 'package:rvi_analyzer/views/common/snack_bar.dart';
import 'package:rvi_analyzer/service/common_service.dart';
import 'package:rvi_analyzer/views/configure/mode_setting.dart';

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
  bool showResult = false;

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
                      "Mode 02",
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
      ),
    );
  }

  void updateSessionID() {
    DateTime now = DateTime.now();
    int milliseconds = now.millisecondsSinceEpoch;

    ref.watch(deviceDataMap[widget.sc.device.id.id]!).sessionIdController.text =
        "S_$milliseconds";
  }

  void setDropDownValue(String? val) {
    if (val != null && val == "Resistance") {
      ref.read(deviceDataMap[widget.sc.device.id.id]!).resSelectedMode02 = true;
    } else {
      ref.read(deviceDataMap[widget.sc.device.id.id]!).resSelectedMode02 =
          false;
    }
    ref.read(deviceDataMap[widget.sc.device.id.id]!).updateStatus();
  }

  String getVoltage() {
    if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
              .currentProtocol ==
          2) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
            .voltage
            .toString());
      }
    }
    return "00";
  }

  String getResistance() {
    if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
              .currentProtocol ==
          2) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
            .resistance
            .toStringAsFixed(3));
      }
    }
    return "00";
  }

  String getCurrent() {
    if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
              .currentProtocol ==
          1) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
            .current
            .toString());
      }
    }
    return "00";
  }

  String getTemp() {
    if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
              .currentProtocol ==
          2) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
            .temperature
            .toString());
      }
    }
    return "00";
  }

  Future<void> saveMode() async {
    double voltage = ref
        .read(ref.read(deviceDataMap[widget.sc.device.id.id]!).streamData)
        .voltage;
    double resistance = double.parse(getResistance());
    ref.read(deviceDataMap[widget.sc.device.id.id]!).saveClickedMode02 = true;

    if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).resSelectedMode02) {
      if (double.parse(ref
                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                  .minResistanceRangeControllerMode02
                  .text) <
              resistance &&
          resistance <
              double.parse(ref
                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                  .maxResistanceRangeControllerMode02
                  .text)) {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).passedMode02 = true;
      } else {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).passedMode02 = false;
      }
    } else {
      if (double.parse(ref
                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                  .minVoltageRangeControllerMode02
                  .text) <
              voltage &&
          voltage <
              double.parse(ref
                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                  .maxVoltageRangeControllerMode02
                  .text)) {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).passedMode02 = true;
      } else {
        ref.read(deviceDataMap[widget.sc.device.id.id]!).passedMode02 = false;
      }
    }

    setState(() {
      showResult = true;
    });

    final loginInfoRepo = LoginInfoRepository();

    List<LoginInfo> infos = await loginInfoRepo.getAllLoginInfos();

    ModeTwo modeTwo = ModeTwo(
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
        sessionConfigurationModeTwo: SessionConfigurationModeTwo(
            current: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .currentControllerMode02
                .text,
            maxVoltage: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .maxVoltageControllerMode02
                .text,
            passMaxVoltage: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .maxVoltageRangeControllerMode02
                .text,
            passMinVoltage: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .minVoltageRangeControllerMode02
                .text),
        results: [
          SessionResult(
              testId: ref
                  .read(deviceDataMap[widget.sc.device.id.id]!)
                  .testIdController
                  .text,
              readings: [
                Reading(
                    temperature: getTemp(),
                    current: getCurrent(),
                    voltage: getVoltage(),
                    result: ref
                            .read(deviceDataMap[widget.sc.device.id.id]!)
                            .passedMode02
                        ? "PASS"
                        : "FAIL",
                    readAt:
                        DateTime.now().toUtc().toString().replaceAll(" ", "T"))
              ])
        ],
        status: "ACTIVE");

    saveModeTwo(modeTwo, infos.first.username)
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
                  .saveClickedMode02 = false
            })
        .onError((error, stackTrace) => {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(getSnackBar(context, Colors.red,
                    "Remote submit failed. Check internet connection")),
              ref
                  .read(deviceDataMap[widget.sc.device.id.id]!)
                  .saveClickedMode02 = false
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .started)),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Select type : ',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(
            height: 5.0,
          ),
          CustomDropDwn(
              data: CustomDropDwnData(
                  inputs: ["Voltage", "Resistance"],
                  updateSelectedIndex: setDropDownValue)),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            ref.watch(deviceDataMap[widget.sc.device.id.id]!).resSelectedMode02
                ? 'Resistance Range : '
                : 'Voltage Range : ',
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(
            height: 5.0,
          ),
          ref.watch(deviceDataMap[widget.sc.device.id.id]!).resSelectedMode02
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextInput(
                          data: TestInputData(
                              controller: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .minResistanceRangeControllerMode02,
                              inputType: TextInputType.number,
                              validatorFun: (val) {
                                if (val!.isEmpty) {
                                  return "Min Resistance cannot be empty";
                                } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                                    .hasMatch(val)) {
                                  return "Only allowed numbers";
                                } else if (!RegExp(
                                        r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,2})?$")
                                    .hasMatch(val)) {
                                  return "Resistance ONLY allowed two Place Value";
                                } else {
                                  null;
                                }
                              },
                              labelText: 'Min \u2126')),
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
                                  .maxResistanceRangeControllerMode02,
                              validatorFun: (val) {
                                if (val!.isEmpty) {
                                  return "Max resistance cannot be empty";
                                } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                                    .hasMatch(val)) {
                                  return "Only allowed numbers";
                                } else if (!RegExp(
                                        r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1,2})?$")
                                    .hasMatch(val)) {
                                  return "Resistance ONLY allowed two Place Value";
                                } else {
                                  null;
                                }
                              },
                              labelText: 'Max \u2126')),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextInput(
                          data: TestInputData(
                              controller: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
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
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
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
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
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
                      .watch(deviceDataMap[widget.sc.device.id.id]!)
                      .currentReadingResistanceControllerMode02,
                  enabled: false,
                  validatorFun: (val) {
                    null;
                  },
                  labelText: 'Resistance : ${getResistance()} \u2126')),
          const SizedBox(
            height: 10,
          ),
          ref.watch(deviceDataMap[widget.sc.device.id.id]!).started &&
                  showResult
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 55,
                        child: CupertinoButton(
                          disabledColor: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .passedMode02
                              ? Colors.green
                              : Colors.red,
                          color: Colors.cyan,
                          onPressed: null,
                          child: Text(
                            ref
                                    .watch(
                                        deviceDataMap[widget.sc.device.id.id]!)
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
          ref.watch(deviceDataMap[widget.sc.device.id.id]!).started
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
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .saveClickedMode02
                              ? null
                              : () {
                                  blue.stop(widget.sc.device);
                                  ref
                                          .read(deviceDataMap[
                                              widget.sc.device.id.id]!)
                                          .started =
                                      !ref
                                          .watch(deviceDataMap[
                                              widget.sc.device.id.id]!)
                                          .started;
                                  ref
                                      .read(deviceDataMap[
                                          widget.sc.device.id.id]!)
                                      .updateStatus();
                                  updateSessionID();
                                  setState(() {
                                    showResult = false;
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
                          onPressed: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .saveClickedMode02
                              ? null
                              : () {
                                  saveMode();
                                },
                          child: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
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
                                                  widget.sc.device.id.id]!)
                                              .currentControllerMode02
                                              .text) *
                                          100)
                                      .toInt(),
                                  (double.parse(ref
                                              .watch(deviceDataMap[
                                                  widget.sc.device.id.id]!)
                                              .maxVoltageControllerMode02
                                              .text) *
                                          10)
                                      .toInt());
                              ref
                                      .read(deviceDataMap[widget.sc.device.id.id]!)
                                      .started =
                                  !ref
                                      .watch(deviceDataMap[
                                          widget.sc.device.id.id]!)
                                      .started;
                              ref
                                  .read(deviceDataMap[widget.sc.device.id.id]!)
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
