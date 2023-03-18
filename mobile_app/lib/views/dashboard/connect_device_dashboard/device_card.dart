import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rvi_analyzer/domain/after_start_data.dart';
import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:rvi_analyzer/service/device_service.dart';
import 'package:rvi_analyzer/views/configure/configure_layout.dart';
import 'package:rvi_analyzer/views/dashboard/connect_device_dashboard/device_status_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/common_service.dart';
import 'package:rvi_analyzer/views/treatment/configure/configure_treatment.dart';
import 'package:rvi_analyzer/views/dashboard/connect_device_dashboard/device_already_running_popup.dart';

class DeviceCardHomePage extends StatefulWidget {
  const DeviceCardHomePage({
    Key? key,
    required this.scanResult,
  }) : super(key: key);

  final ScanResult scanResult;

  @override
  State<DeviceCardHomePage> createState() =>
      _deviceCardHomePageState(scanResult);
}

class _deviceCardHomePageState extends State<DeviceCardHomePage> {
  _deviceCardHomePageState(this.scanResult);
  final ScanResult scanResult;
  bool isClicked = false;
  bool isDisconnectPressed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Consumer(
          builder: (context, ref, child) {
            void connect() async {
              setState(() {
                isClicked = true;
              });
              // await validateDeviceByName(scanResult.device.name).then((value) =>
              //     {
              //       if (value.status == "S1000")
              //         {
              scanResult.device
                  .connect()
                  .then((value) => {
                        ref.read(deviceManagementState).addDevice(scanResult),
                        deviceDataMap.putIfAbsent(
                            scanResult.device.name,
                            () =>
                                ChangeNotifierProvider((ref) => DeviceState())),
                        deviceConnectionStatusMap.putIfAbsent(
                            scanResult.device.name,
                            () => ChangeNotifierProvider(
                                (ref) => BluetoothDeviceStatus(scanResult))),
                        ref
                            .read(deviceConnectionStatusMap[
                                    scanResult.device.name]!
                                .notifier)
                            .activeNotifyStreamListener(),
                        ref
                            .read(
                                deviceDataMap[scanResult.device.name]!.notifier)
                            .isConnected = true,
                        ref
                            .read(ref
                                .read(deviceDataMap[scanResult.device.name]!)
                                .streamData)
                            .runNotify(scanResult),
                      })
                  .onError((error, stackTrace) => {
                        setState(() {
                          isClicked = false;
                        }),
                      });
              //     }
              //   else
              //     {
              //       setState(() {
              //         isClicked = false;
              //       }),
              //     }
              // });
            }

            void disconnect() async {
              setState(() {
                isDisconnectPressed = true;
              });
              Timer(const Duration(seconds: 1), () {
                ref
                    .read(deviceManagementState)
                    .disconnectDevice(widget.scanResult)
                    .then((value) => {
                          ref
                              .read(
                                  deviceDataMap[widget.scanResult.device.name]!
                                      .notifier)
                              .isConnected = false,
                          if (deviceConnectionStatusMap
                              .containsKey(widget.scanResult.device.name))
                            {
                              ref
                                  .read(deviceConnectionStatusMap[
                                          widget.scanResult.device.name]!
                                      .notifier)
                                  .alreadyListening = false,
                              ref
                                  .read(deviceConnectionStatusMap[
                                          widget.scanResult.device.name]!
                                      .notifier)
                                  .cancelSubscription(),
                              deviceConnectionStatusMap
                                  .remove(widget.scanResult.device.name),
                            },
                          ref
                              .read(ref
                                  .read(deviceDataMap[
                                      widget.scanResult.device.name]!)
                                  .streamData
                                  .notifier)
                              .subscription
                              .cancel(),
                          setState(() {
                            isDisconnectPressed = false;
                          }),
                        });
              });
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 0.5), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side:
                      const BorderSide(color: Color.fromARGB(255, 34, 197, 94)),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(flex: 2, child: Icon(Icons.computer)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(scanResult.device.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black)),
                          deviceDataMap.containsKey(scanResult.device.name)
                              ? DeviceStatusText(scanResult)
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                    deviceConnectionStatusMap
                                .containsKey(scanResult.device.name) &&
                            (ref
                                        .read(deviceConnectionStatusMap[
                                                scanResult.device.name]!
                                            .notifier)
                                        .state ==
                                    "connected" ||
                                ref
                                        .read(deviceConnectionStatusMap[
                                                scanResult.device.name]!
                                            .notifier)
                                        .state ==
                                    "")
                        ? Row(
                            children: [
                              SizedBox(
                                height: 35,
                                width: 90,
                                child: CupertinoButton(
                                  color: Colors.red,
                                  disabledColor: Colors.grey,
                                  padding: const EdgeInsets.all(0),
                                  onPressed: isClicked
                                      ? null
                                      : () {
                                          disconnect();
                                        },
                                  child: isDisconnectPressed
                                      ? const SpinKitWave(
                                          color: Colors.white,
                                          size: 15.0,
                                        )
                                      : const Text(
                                          'Disconnect',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 231, 230, 230)),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: 35,
                                width: 80,
                                child: CupertinoButton(
                                  color: Colors.green,
                                  padding: const EdgeInsets.all(0),
                                  onPressed: isClicked
                                      ? null
                                      : () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ConfigureLayout(
                                                          sc: scanResult)));
                                        },
                                  child: const Text(
                                    'Configure',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 231, 230, 230)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              SizedBox(
                                height: 35,
                                width: 80,
                                child: CupertinoButton.filled(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: isClicked
                                      ? null
                                      : () {
                                          connect();
                                        },
                                  child: isClicked
                                      ? const SpinKitWave(
                                          color: Colors.white,
                                          size: 15.0,
                                        )
                                      : const Text(
                                          'Connect',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 231, 230, 230)),
                                        ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
                tileColor: const Color.fromARGB(255, 255, 255, 255),
                onTap: () => {
                  // if (ref.watch(deviceDataMap[scanResult.device.name]!).config !=
                  //     null)
                  //   {
                  //     PersistentNavBarNavigator.pushNewScreen(
                  //       context,
                  //       screen: TreatmentRunning(RunningTreatmentData(
                  //           config: ref
                  //               .watch(deviceDataMap[scanResult.device.name]!)
                  //               .config!,
                  //           scanResult: scanResult,
                  //           userName: "")),
                  //       withNavBar: false,
                  //       pageTransitionAnimation:
                  //           PageTransitionAnimation.cupertino,
                  //     )
                  //   }
                  // else
                  //   {
                  //     if ([3].contains(ref
                  //         .watch(ref
                  //             .watch(deviceDataMap[scanResult.device.name]!)
                  //             .streamData)
                  //         .state))
                  //       {
                  //         DeviceRunningStop().showRunningStopPopup(
                  //             context, scanResult, "Device already Running")
                  //       }
                  //     else if ([6].contains(ref
                  //         .watch(ref
                  //             .watch(deviceDataMap[scanResult.device.name]!)
                  //             .streamData)
                  //         .state))
                  //       {
                  //         DeviceRunningStop().showRunningStopPopup(
                  //             context, scanResult, "Device Paused")
                  //       }
                  //     else if (ref
                  //             .watch(ref
                  //                 .watch(deviceDataMap[scanResult.device.name]!)
                  //                 .streamData)
                  //             .state ==
                  //         9)
                  //       {
                  //         showErrorDialog(
                  //             context, "Device was manually operating")
                  //       }
                  //     else
                  //       {
                  //         PersistentNavBarNavigator.pushNewScreen(
                  //           context,
                  //           screen: ConfigureDashboard(scanResult),
                  //           withNavBar: false,
                  //           pageTransitionAnimation:
                  //               PageTransitionAnimation.cupertino,
                  //         )
                  //       }
                  //   },
                },
              ),
            );
          },
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
