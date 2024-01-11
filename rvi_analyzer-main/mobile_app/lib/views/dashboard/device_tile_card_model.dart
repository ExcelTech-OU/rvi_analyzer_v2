import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/common_service.dart';
import 'package:rvi_analyzer/service/device_service.dart';
import 'package:rvi_analyzer/providers/connected_devices_provider.dart';

class DeviceTileCardModel extends StatefulWidget {
  final ScanResult scanResult;

  const DeviceTileCardModel(this.scanResult, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DeviceTileCardModelState(scanResult);
  }
}

class _DeviceTileCardModelState extends State<DeviceTileCardModel> {
  ScanResult scanResult;
  _DeviceTileCardModelState(this.scanResult);
  bool buttonEnabled = false;
  bool isReadyState = false;
  bool isRunningState = false;
  bool isFirstRun = false;

  @override
  void initState() {
    super.initState();
    buttonEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Consumer(builder: ((context, ref, child) {
        return ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          tileColor: const Color.fromARGB(132, 76, 75, 75),
          title: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Text(scanResult.device.name,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 189, 189, 189)))),
              Expanded(
                flex: 1,
                child: buttonEnabled
                    ? const CupertinoActivityIndicator(
                        color: Color.fromARGB(255, 189, 189, 189),
                      )
                    : const Text(""),
              ),
            ],
          ),
          onTap: () async {
            setState(() {
              buttonEnabled = true;
            });
            validateDeviceByMac(scanResult.device.id.id).then((value) => {
                  if (value.status == "S1000")
                    {
                      scanResult.device
                          .connect(autoConnect: false)
                          .then((value) => {
                                ref
                                    .read(deviceManagementState)
                                    .addDevice(scanResult),
                                deviceDataMap.putIfAbsent(
                                    scanResult.device.id.id,
                                    () => ChangeNotifierProvider(
                                        (ref) => DeviceState())),
                                ref
                                    .read(
                                        deviceDataMap[scanResult.device.id.id]!
                                            .notifier)
                                    .isConnected = true,
                                ref
                                    .read(ref
                                        .read(deviceDataMap[
                                            scanResult.device.id.id]!)
                                        .streamData)
                                    .runNotify(scanResult),
                                Navigator.pop(context, 'OK')
                              })
                          .onError((error, stackTrace) => {
                                setState(() {
                                  buttonEnabled = false;
                                }),
                                showErrorDialog(context,
                                    "Error while connecting. Please try again")
                              })
                    }
                  else
                    {
                      setState(() {
                        buttonEnabled = false;
                      }),
                      showErrorDialog(context,
                          "Device was not active. Please contact device admin"),
                    }
                });
          },
        );
      })),
    );
  }
}
