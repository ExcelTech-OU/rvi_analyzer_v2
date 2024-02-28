import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';
import 'package:rvi_analyzer/repository/entity/mode_seven_entity.dart';
import 'package:rvi_analyzer/repository/login_repo.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/service/mode_service.dart';
import 'package:rvi_analyzer/views/common/form_eliments/dropdown.dart';
import 'package:rvi_analyzer/views/common/form_eliments/dropdown_custom.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';
import 'package:rvi_analyzer/views/common/snack_bar.dart';
import 'package:rvi_analyzer/service/common_service.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ConfigureRightPanelType07 extends ConsumerStatefulWidget {
  final ScanResult sc;
  final GlobalKey<FormState> keyForm;
  final void Function() updateTestId;
  const ConfigureRightPanelType07(
      {Key? key,
      required this.sc,
      required this.keyForm,
      required this.updateTestId})
      : super(key: key);

  @override
  ConsumerState<ConfigureRightPanelType07> createState() =>
      _ConfigureRightPanelType07State();
}

class _ConfigureRightPanelType07State
    extends ConsumerState<ConfigureRightPanelType07> {
  Blue blue = Blue();
  final _formKey = GlobalKey<FormState>();
  HashMap<String, ScanResult> blueDeviceList = HashMap();
  List<String> deviceNames = [];
  List<String> deviceMacs = [];
  bool scanClicked = false;
  TextEditingController macController = TextEditingController();

  void updateSessionID() {
    DateTime now = DateTime.now();
    int milliseconds = now.millisecondsSinceEpoch;

    ref.watch(deviceDataMap[widget.sc.device.id.id]!).sessionIdController.text =
        "S_$milliseconds";
  }

  void setDropDownValue(String? val) {
    int index = int.parse(val!);
    macController.text = deviceMacs.length > index ? deviceMacs[index] : "";
  }

  String getVoltage() {
    if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
              .currentProtocol ==
          1) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
            .voltage
            .toString());
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

  String getResistance() {
    if (ref.watch(deviceDataMap[widget.sc.device.id.id]!).started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
              .currentProtocol ==
          1) {
        return ((double.parse(ref
                    .watch(deviceDataMap[widget.sc.device.id.id]!)
                    .voltageControllerMode01
                    .text) /
                ref
                    .watch(ref
                        .watch(deviceDataMap[widget.sc.device.id.id]!)
                        .streamData)
                    .current)
            .toStringAsFixed(3));
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
          1) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.id.id]!).streamData)
            .temperature
            .toString());
      }
    }
    return "00";
  }

  Future<void> saveMode() async {
    ref.read(deviceDataMap[widget.sc.device.id.id]!).saveClickedMode07 = true;

    final loginInfoRepo = LoginInfoRepository();

    List<LoginInfo> infos = await loginInfoRepo.getAllLoginInfos();

    ModeSeven modeSeven = ModeSeven(
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
            batchNo: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .batchNoController
                .text,
            serialNo: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .serialNoController
                .text,
            sessionId: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .sessionIdController
                .text),
        result: SessionResultModeSeven(
            testId: ref
                .read(deviceDataMap[widget.sc.device.id.id]!)
                .testIdController
                .text,
            reading: SessionSevenReading(
                resistance: getResistance(),
                current: getCurrent(),
                voltage: getVoltage(),
                macAddress: macController.text,
                productionOrder: ref
                    .read(deviceDataMap[widget.sc.device.id.id]!)
                    .poNumberControllerMode7
                    .text,
                result: ref
                            .read(deviceDataMap[widget.sc.device.id.id]!)
                            .selectedIndexMode07 ==
                        0
                    ? "PASS"
                    : "FAIL",
                readAt:
                    DateTime.now().toUtc().toString().replaceAll(" ", "T"))),
        status: "ACTIVE");

    saveModeSeven(modeSeven, infos.first.username)
        .then((value) => {
              if (value.status == "S1000")
                {
                  setState(() {
                    deviceMacs = [];
                    deviceNames = [];
                  }),
                  macController.text = "",
                  ref.read(deviceDataMap[widget.sc.device.id.id]!).started =
                      !ref.read(deviceDataMap[widget.sc.device.id.id]!).started,
                  ref
                      .read(deviceDataMap[widget.sc.device.id.id]!)
                      .updateStatus(),
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
                    ..showSnackBar(getSnackBar(
                        context, Colors.red, "Remote submit failed."))
                },
              ref
                  .read(deviceDataMap[widget.sc.device.id.id]!)
                  .saveClickedMode07 = false
            })
        .onError((error, stackTrace) => {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    getSnackBar(context, Colors.red, "Remote submit failed.")),
              ref
                  .read(deviceDataMap[widget.sc.device.id.id]!)
                  .saveClickedMode07 = false
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
                        inputType: TextInputType.text,
                        controller: ref
                            .read(deviceDataMap[widget.sc.device.id.id]!)
                            .poNumberControllerMode7,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "PO cannot be empty";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Production Order',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.id.id]!)
                            .started)),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Select Device : ',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: CustomDropDwn2(
                    data: CustomDropDwnData(
                        inputs: deviceNames,
                        updateSelectedIndex: setDropDownValue,
                        hindText: 'Select Device',
                        customData: deviceMacs)),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                    height: 62,
                    child: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        disabledColor: Colors.grey,
                        color: Colors.orange,
                        onPressed: scanClicked ||
                                ref
                                    .watch(
                                        deviceDataMap[widget.sc.device.id.id]!)
                                    .started
                            ? null
                            : () async {
                                setState(() {
                                  scanClicked = true;
                                  deviceNames = [];
                                  deviceMacs = [];
                                });
                                macController.text = "";
                                blueDeviceList =
                                    await blue.scanDevicesWithFilters("Magma");
                                List<String> tmpDevices = [];
                                List<String> tmpMacs = [];
                                blueDeviceList.forEach((key, value) {
                                  tmpDevices.add(value.device.name);
                                  tmpMacs.add(value.device.id.id);
                                });

                                setState(() {
                                  deviceNames = tmpDevices;
                                  deviceMacs = tmpMacs;
                                  scanClicked = false;
                                });
                                macController.text = deviceMacs.isNotEmpty
                                    ? deviceMacs.first
                                    : "";
                              },
                        child: scanClicked
                            ? const SpinKitDoubleBounce(
                                color: Colors.white,
                                size: 30.0,
                              )
                            : const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ))),
              )
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
                        controller: macController,
                        inputType: TextInputType.number,
                        enabled: false,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Select a device";
                          } else {
                            null;
                          }
                        },
                        labelText: 'MAC : ${macController.text}')),
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
                            .read(deviceDataMap[widget.sc.device.id.id]!)
                            .currentReadingCurrentControllerMode07,
                        enabled: false,
                        validatorFun: (val) {
                          null;
                        },
                        labelText: 'Current : ${getCurrent()} \u2103')),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextInput(
                    data: TestInputData(
                        controller: ref
                            .read(deviceDataMap[widget.sc.device.id.id]!)
                            .currentReadingVoltageControllerMode07,
                        inputType: TextInputType.number,
                        enabled: false,
                        validatorFun: (val) {
                          null;
                        },
                        labelText: 'Voltage : ${getVoltage()} A')),
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
                            .read(deviceDataMap[widget.sc.device.id.id]!)
                            .currentReadingResistanceControllerMode07,
                        enabled: false,
                        validatorFun: (val) {
                          null;
                        },
                        labelText: 'Resistance : ${getResistance()} \u2103')),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                flex: 2,
                child: Text(
                  'LED Sequence : ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                height: 55,
                child: ToggleSwitch(
                  minWidth: 120.0,
                  cornerRadius: 12.0,
                  activeBgColors: [
                    [Colors.green[800]!],
                    [Colors.red[800]!]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: ref
                      .read(deviceDataMap[widget.sc.device.id.id]!)
                      .selectedIndexMode07,
                  totalSwitches: 2,
                  labels: const ['Passed', 'Failed'],
                  radiusStyle: true,
                  onToggle: (index) {
                    ref
                        .read(deviceDataMap[widget.sc.device.id.id]!)
                        .selectedIndexMode07 = index!;
                  },
                ),
              ),
            ],
          ),
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
                                  .saveClickedMode07
                              ? null
                              : () {
                                  ref
                                          .read(deviceDataMap[
                                              widget.sc.device.id.id]!)
                                          .started =
                                      !ref
                                          .read(deviceDataMap[
                                              widget.sc.device.id.id]!)
                                          .started;
                                  ref
                                      .read(deviceDataMap[
                                          widget.sc.device.id.id]!)
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
                          onPressed: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .saveClickedMode07
                              ? null
                              : () {
                                  saveMode();
                                },
                          child: ref
                                  .watch(deviceDataMap[widget.sc.device.id.id]!)
                                  .saveClickedMode07
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
                              ref
                                      .read(deviceDataMap[widget.sc.device.id.id]!)
                                      .started =
                                  !ref
                                      .read(deviceDataMap[
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

  @override
  Widget build(BuildContext context) {
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
                  const Row(
                    children: [
                      Text(
                        "Mode 07",
                        style: TextStyle(
                            fontSize: 30,
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
