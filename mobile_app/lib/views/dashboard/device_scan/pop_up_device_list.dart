import 'package:rvi_analyzer/domain/device_list_drop_and_popup_data.dart';
import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/common_service.dart';
import 'package:rvi_analyzer/service/device_service.dart';
import 'package:rvi_analyzer/views/dashboard/device_scan/drop_down_device_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceListPopUpV2 {
  Future<void> showMyDialog(
      BuildContext context, DeviceListDropAndPopUpData dropDownData) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        int selectedIndex = dropDownData.defaultIndex;
        bool connectPressed = false;
        bool forFinished = false;
        List<ScanResult> selectedDeviceList = [];
        List<ScanResult> disabledDeviceList = [];
        List<ScanResult> connectedDeviceList = [];
        List<ScanResult> connectionFailedDeviceList = [];
        double width = MediaQuery.of(context).size.width;
        return StatefulBuilder(builder: (context, setState) {
          return Consumer(builder: ((context, ref, child) {
            void updateSelectedDeviceList(
                ScanResult scanResult, bool selected) {
              if (selected) {
                setState(() {
                  if (!selectedDeviceList.contains(scanResult)) {
                    selectedDeviceList.add(scanResult);
                  }
                });
              } else {
                setState(() {
                  if (selectedDeviceList.contains(scanResult)) {
                    selectedDeviceList.remove(scanResult);
                  }
                });
              }
            }

            void finish(ScanResult scanResult) {
              if (selectedDeviceList.contains(scanResult) &&
                  selectedDeviceList.last == scanResult) {
                setState(() {
                  forFinished = true;
                });
              }
              if (forFinished) {
                if (disabledDeviceList.isEmpty &&
                    connectionFailedDeviceList.isEmpty) {
                  dropDownData.forceClose(connectedDeviceList);
                } else {
                  String connectionFailedDeviceNames = "";
                  for (var element in connectionFailedDeviceList) {
                    connectionFailedDeviceNames =
                        "$connectionFailedDeviceNames ${element.device.name}";
                  }

                  String disabledDeviceNames = "";
                  for (var element in disabledDeviceList) {
                    disabledDeviceNames =
                        "$disabledDeviceNames ${element.device.name}";
                  }
                  if (disabledDeviceNames.isNotEmpty &&
                      connectionFailedDeviceNames.isNotEmpty) {
                    showErrorDialog(context,
                        "Devices [$disabledDeviceNames] was not in active state & \n Devices [$connectionFailedDeviceNames] connection failed");
                  } else if (disabledDeviceNames.isNotEmpty) {
                    showErrorDialog(context,
                        "Devices [$disabledDeviceNames] was not in active state");
                  } else {
                    showErrorDialog(context,
                        "Devices [$connectionFailedDeviceNames] connection failed");
                  }

                  setState(() {
                    connectPressed = false;
                    disabledDeviceList.clear();
                    connectionFailedDeviceList.clear();
                  });
                }
              }
            }

            void connect() async {
              setState(() {
                connectPressed = true;
                forFinished = false;
              });
              for (var scanResult in selectedDeviceList) {
                await validateDeviceByName(scanResult.device.name)
                    .then((value) => {
                          if (value.status == "S1000")
                            {
                              scanResult.device
                                  .connect()
                                  .then((value) => {
                                        setState(() {
                                          if (!connectedDeviceList
                                              .contains(scanResult)) {
                                            connectedDeviceList.add(scanResult);
                                          }
                                        }),
                                        ref
                                            .read(deviceManagementState)
                                            .addDevice(scanResult),
                                        deviceDataMap.putIfAbsent(
                                            scanResult.device.name,
                                            () => ChangeNotifierProvider(
                                                (ref) => DeviceState())),
                                        deviceConnectionStatusMap.putIfAbsent(
                                            scanResult.device.name,
                                            () => ChangeNotifierProvider(
                                                (ref) => BluetoothDeviceStatus(
                                                    scanResult))),
                                        ref
                                            .read(deviceConnectionStatusMap[
                                                    scanResult.device.name]!
                                                .notifier)
                                            .activeNotifyStreamListener(),
                                        ref
                                            .read(deviceDataMap[
                                                    scanResult.device.name]!
                                                .notifier)
                                            .isConnected = true,
                                        ref
                                            .read(ref
                                                .read(deviceDataMap[
                                                    scanResult.device.name]!)
                                                .streamData)
                                            .runNotify(scanResult),
                                        finish(scanResult)
                                      })
                                  .onError((error, stackTrace) => {
                                        setState(() {
                                          if (!connectionFailedDeviceList
                                              .contains(scanResult)) {
                                            connectionFailedDeviceList
                                                .add(scanResult);
                                          }
                                        }),
                                        finish(scanResult)
                                      })
                            }
                          else
                            {
                              setState(() {
                                if (!disabledDeviceList.contains(scanResult)) {
                                  disabledDeviceList.add(scanResult);
                                }
                              }),
                              finish(scanResult)
                            }
                        });
              }
            }

            return AlertDialog(
              insetPadding: const EdgeInsets.all(15),
              backgroundColor: const Color.fromARGB(255, 30, 41, 59),
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              elevation: 24.0,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ref.watch(deviceManagementState).availableDeviceList.isEmpty
                        ? const Center(
                            child: Text('No device available',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 255, 255, 255))),
                          )
                        : Column(
                            children: [
                              for (var scanResult in dropDownData.items.values)
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: DeviceListTile(
                                      scanResult: scanResult,
                                      updateDeviceToList:
                                          updateSelectedDeviceList),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: SizedBox(
                                    width: width - 20,
                                    height: 60,
                                    child: CupertinoButton(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        color: const Color.fromARGB(
                                            255, 34, 197, 94),
                                        onPressed: () {
                                          connect();
                                        },
                                        child: connectPressed
                                            ? const CupertinoActivityIndicator()
                                            : const Text('Connect',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(0.0),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      dropDownData.popupClose();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      Icons.cancel_rounded,
                                      color: Color.fromARGB(255, 127, 134, 143),
                                      size: 45,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                  ],
                ),
              ),
            );
          }));
        });
      },
    );
  }
}
