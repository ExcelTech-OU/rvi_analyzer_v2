import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';

class ConfigureRightPanelType01 extends ConsumerStatefulWidget {
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
  const ConfigureRightPanelType01(
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
  ConsumerState<ConfigureRightPanelType01> createState() =>
      _ConfigureRightPanelType01State();
}

class _ConfigureRightPanelType01State
    extends ConsumerState<ConfigureRightPanelType01> {
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
                        "Mode 01",
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

  String getVoltage() {
    if (ref.watch(deviceDataMap[widget.sc.device.name]!).mode01Started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
              .currentProtocol ==
          1) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
            .voltage
            .toString());
      }
    }
    return "00";
  }

  String getCurrent() {
    if (ref.watch(deviceDataMap[widget.sc.device.name]!).mode01Started) {
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

  String getResistance() {
    if (ref.watch(deviceDataMap[widget.sc.device.name]!).mode01Started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
              .currentProtocol ==
          1) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
            .resistance
            .toStringAsFixed(3));
      }
    }
    return "00";
  }

  String getTemp() {
    if (ref.watch(deviceDataMap[widget.sc.device.name]!).mode01Started) {
      if (ref
              .watch(
                  ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
              .currentProtocol ==
          1) {
        return (ref
            .watch(ref.watch(deviceDataMap[widget.sc.device.name]!).streamData)
            .temperature
            .toString());
      }
    }
    return "00";
  }

  void saveModeOne() {
    double current = ref
        .read(ref.read(deviceDataMap[widget.sc.device.name]!).streamData)
        .current;
    ref.read(deviceDataMap[widget.sc.device.name]!).mode01SaveClicked = true;

    if (double.parse(ref
                .watch(deviceDataMap[widget.sc.device.name]!)
                .minCurrentRangeControllerMode01
                .text) <
            current &&
        current <
            double.parse(ref
                .watch(deviceDataMap[widget.sc.device.name]!)
                .maxCurrentRangeControllerMode01
                .text)) {
      ref.read(deviceDataMap[widget.sc.device.name]!).mode01Passed = true;
    } else {
      ref.read(deviceDataMap[widget.sc.device.name]!).mode01Passed = false;
    }
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
                            .read(deviceDataMap[widget.sc.device.name]!)
                            .voltageControllerMode01,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Voltage cannot be empty";
                          } else if (!RegExp(r"^(?=\D*(?:\d\D*){1,12}$)")
                              .hasMatch(val)) {
                            return "Only allowed numbers";
                          } else if (!RegExp(
                                  r"^(?=\D*(?:\d\D*){1,12}$)\d+(?:\.\d{1})?$")
                              .hasMatch(val)) {
                            return "Voltage ONLY allowed one Place Value";
                          } else {
                            null;
                          }
                        },
                        labelText: 'Voltage (V)',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .mode01Started)),
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
                            .read(deviceDataMap[widget.sc.device.name]!)
                            .maxCurrentControllerMode01,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Max current cannot be empty";
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
                        labelText: 'Max current (A)',
                        enabled: !ref
                            .watch(deviceDataMap[widget.sc.device.name]!)
                            .mode01Started)),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Current Range : ',
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
                            .read(deviceDataMap[widget.sc.device.name]!)
                            .minCurrentRangeControllerMode01,
                        inputType: TextInputType.number,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Min current cannot be empty";
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
                        labelText: 'Min (A)')),
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
                            .read(deviceDataMap[widget.sc.device.name]!)
                            .maxCurrentRangeControllerMode01,
                        validatorFun: (val) {
                          if (val!.isEmpty) {
                            return "Max current cannot be empty";
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
                        labelText: 'Max (A)')),
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
                            .read(deviceDataMap[widget.sc.device.name]!)
                            .currentReadingVoltageControllerMode01,
                        inputType: TextInputType.number,
                        enabled: false,
                        validatorFun: (val) {
                          null;
                        },
                        labelText: 'Current : ${getCurrent()} A')),
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
                            .read(deviceDataMap[widget.sc.device.name]!)
                            .currentReadingTemControllerMode01,
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
                      .read(deviceDataMap[widget.sc.device.name]!)
                      .currentReadingResistanceControllerMode01,
                  enabled: false,
                  validatorFun: (val) {
                    null;
                  },
                  labelText: 'Resistance : ${getResistance()} \u2126')),
          const SizedBox(
            height: 10,
          ),
          ref.watch(deviceDataMap[widget.sc.device.name]!).mode01Started &&
                  ref
                      .watch(deviceDataMap[widget.sc.device.name]!)
                      .mode01SaveClicked
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 55,
                        child: CupertinoButton(
                          disabledColor: ref
                                  .watch(deviceDataMap[widget.sc.device.name]!)
                                  .mode01Passed
                              ? Colors.green
                              : Colors.red,
                          color: Colors.cyan,
                          onPressed: null,
                          child: Text(
                            ref
                                    .watch(
                                        deviceDataMap[widget.sc.device.name]!)
                                    .mode01Passed
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
          ref.watch(deviceDataMap[widget.sc.device.name]!).mode01Started
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
                                    .read(deviceDataMap[widget.sc.device.name]!)
                                    .mode01Started =
                                !ref
                                    .read(deviceDataMap[widget.sc.device.name]!)
                                    .mode01Started;
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
                              blue.runMode01(
                                  widget.sc.device,
                                  (double.parse(ref
                                              .read(deviceDataMap[
                                                  widget.sc.device.name]!)
                                              .voltageControllerMode01
                                              .text) *
                                          10)
                                      .toInt(),
                                  (double.parse(ref
                                              .read(deviceDataMap[
                                                  widget.sc.device.name]!)
                                              .maxCurrentControllerMode01
                                              .text) *
                                          100)
                                      .toInt());
                              ref
                                      .read(deviceDataMap[widget.sc.device.name]!)
                                      .mode01Started =
                                  !ref
                                      .read(
                                          deviceDataMap[widget.sc.device.name]!)
                                      .mode01Started;
                              widget.updateStarted();
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
