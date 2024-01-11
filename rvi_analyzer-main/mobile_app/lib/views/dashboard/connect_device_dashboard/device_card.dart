import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rvi_analyzer/service/common_service.dart';
import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:rvi_analyzer/repository/connected_devices_info_repo.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';
import 'package:rvi_analyzer/repository/login_repo.dart';
import 'package:rvi_analyzer/service/device_service.dart';
import 'package:rvi_analyzer/views/configure/configure_layout.dart';
import 'package:rvi_analyzer/views/dashboard/connect_device_dashboard/device_status_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rvi_analyzer/providers/device_state_provider.dart';

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

  final ConnectedDevicesInfoRepository connectedRepo =
      ConnectedDevicesInfoRepository();

  final loginInfoRepo = LoginInfoRepository();

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
              await validateDeviceByMac(scanResult.device.id.id).then((value) =>
                  {
                    if (value.status == "S1000")
                      {
                        scanResult.device
                            .connect(autoConnect: false)
                            .then((value) async {
                          List<LoginInfo> infos =
                              await loginInfoRepo.getAllLoginInfos();

                          await connectedRepo.addDeviceByUserName(
                              infos.first.username, scanResult);

                          ref.read(deviceManagementState).addDevice(scanResult);
                          deviceDataMap.putIfAbsent(
                              scanResult.device.id.id,
                              () => ChangeNotifierProvider(
                                  (ref) => DeviceState()));
                          deviceConnectionStatusMap.putIfAbsent(
                              scanResult.device.id.id,
                              () => ChangeNotifierProvider(
                                  (ref) => BluetoothDeviceStatus(scanResult)));
                          ref
                              .read(deviceConnectionStatusMap[
                                      scanResult.device.id.id]!
                                  .notifier)
                              .activeNotifyStreamListener();
                          ref
                              .read(deviceDataMap[scanResult.device.id.id]!
                                  .notifier)
                              .isConnected = true;
                          ref
                              .read(ref
                                  .read(deviceDataMap[scanResult.device.id.id]!)
                                  .streamData)
                              .runNotify(scanResult);
                        }).onError((error, stackTrace) {
                          setState(() {
                            isClicked = false;
                          });
                        })
                      }
                    else
                      {
                        showErrorDialog(context,
                            "Device Authentication failed. Please contact administrator"),
                        setState(() {
                          isClicked = false;
                        }),
                      }
                  });
            }

            void disconnect() async {
              setState(() {
                isDisconnectPressed = true;
              });
              Timer(const Duration(seconds: 1), () {
                ref
                    .read(deviceManagementState)
                    .disconnectDevice(widget.scanResult)
                    .then((value) async {
                  // List<LoginInfo> infos =
                  //     await loginInfoRepo.getAllLoginInfos();

                  // await connectedRepo.removeByName(
                  //     infos.first.username, scanResult);
                  ref
                      .read(deviceDataMap[widget.scanResult.device.id.id]!
                          .notifier)
                      .isConnected = false;
                  if (deviceConnectionStatusMap
                      .containsKey(widget.scanResult.device.id.id)) {
                    ref
                        .read(deviceConnectionStatusMap[
                                widget.scanResult.device.id.id]!
                            .notifier)
                        .alreadyListening = false;
                    ref
                        .read(deviceConnectionStatusMap[
                                widget.scanResult.device.id.id]!
                            .notifier)
                        .cancelSubscription();
                    deviceConnectionStatusMap
                        .remove(widget.scanResult.device.id.id);
                  }
                  ref
                      .read(ref
                          .read(deviceDataMap[widget.scanResult.device.id.id]!)
                          .streamData
                          .notifier)
                      .subscription
                      .cancel();
                  setState(() {
                    isDisconnectPressed = false;
                  });
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
                          Text(scanResult.device.id.id,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.grey)),
                          deviceDataMap.containsKey(scanResult.device.id.id)
                              ? DeviceStatusText(scanResult)
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                    deviceConnectionStatusMap
                                .containsKey(scanResult.device.id.id) &&
                            (ref
                                        .read(deviceConnectionStatusMap[
                                                scanResult.device.id.id]!
                                            .notifier)
                                        .state ==
                                    "connected" ||
                                ref
                                        .read(deviceConnectionStatusMap[
                                                scanResult.device.id.id]!
                                            .notifier)
                                        .state ==
                                    "")
                        ? Row(
                            children: [
                              SizedBox(
                                height: 45,
                                width: 90,
                                child: CupertinoButton(
                                  color: Colors.red,
                                  disabledColor: Colors.grey,
                                  padding: const EdgeInsets.all(0),
                                  onPressed: isClicked
                                      ? null
                                      : () {
                                          //disconnect();
                                          connect();
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
                                height: 45,
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
                                height: 45,
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
                  // if (ref.watch(deviceDataMap[scanResult.device.id.id]!).config !=
                  //     null)
                  //   {
                  //     PersistentNavBarNavigator.pushNewScreen(
                  //       context,
                  //       screen: TreatmentRunning(RunningTreatmentData(
                  //           config: ref
                  //               .watch(deviceDataMap[scanResult.device.id.id]!)
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
                  //             .watch(deviceDataMap[scanResult.device.id.id]!)
                  //             .streamData)
                  //         .state))
                  //       {
                  //         DeviceRunningStop().showRunningStopPopup(
                  //             context, scanResult, "Device already Running")
                  //       }
                  //     else if ([6].contains(ref
                  //         .watch(ref
                  //             .watch(deviceDataMap[scanResult.device.id.id]!)
                  //             .streamData)
                  //         .state))
                  //       {
                  //         DeviceRunningStop().showRunningStopPopup(
                  //             context, scanResult, "Device Paused")
                  //       }
                  //     else if (ref
                  //             .watch(ref
                  //                 .watch(deviceDataMap[scanResult.device.id.id]!)
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
