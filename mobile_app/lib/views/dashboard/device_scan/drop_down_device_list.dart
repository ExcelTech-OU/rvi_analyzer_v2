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

class DropDownCustomDeviceList extends ConsumerStatefulWidget {
  final DeviceListDropAndPopUpData dropDownData;
  const DropDownCustomDeviceList(this.dropDownData, {Key? key})
      : super(key: key);

  @override
  ConsumerState<DropDownCustomDeviceList> createState() =>
      _DropDownCustomState(dropDownData);
}

class _DropDownCustomState extends ConsumerState<DropDownCustomDeviceList> {
  late DeviceListDropAndPopUpData dropDownData;
  int selectedIndex = -1;
  bool connectPressed = false;
  List<ScanResult> selectedDeviceList = [];
  List<ScanResult> disabledDeviceList = [];
  List<ScanResult> connectedDeviceList = [];
  List<ScanResult> connectionFailedDeviceList = [];

  _DropDownCustomState(this.dropDownData) {
    selectedIndex = dropDownData.defaultIndex;
  }

  void updateSelectedDeviceList(ScanResult scanResult, bool selected) {
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

  void connect() async {
    setState(() {
      connectPressed = true;
    });
    for (var scanResult in selectedDeviceList) {
      await validateDeviceByName(scanResult.device.name).then((value) => {
            if (value.status == "S1000")
              {
                scanResult.device
                    .connect()
                    .then((value) => {
                          setState(() {
                            if (!connectedDeviceList.contains(scanResult)) {
                              connectedDeviceList.add(scanResult);
                            }
                          }),
                          ref.read(deviceManagementState).addDevice(scanResult),
                          deviceDataMap.putIfAbsent(
                              scanResult.device.name,
                              () => ChangeNotifierProvider(
                                  (ref) => DeviceState())),
                          ref
                              .read(deviceDataMap[scanResult.device.name]!
                                  .notifier)
                              .isConnected = true,
                          ref
                              .read(ref
                                  .read(deviceDataMap[scanResult.device.name]!)
                                  .streamData)
                              .runNotify(scanResult),
                          // Navigator.pop(context, 'OK')
                        })
                    .onError((error, stackTrace) => {
                          setState(() {
                            if (!connectionFailedDeviceList
                                .contains(scanResult)) {
                              connectionFailedDeviceList.add(scanResult);
                            }
                          }),
                        })
              }
            else
              {
                print("Diable divice"),
                setState(() {
                  if (!disabledDeviceList.contains(scanResult)) {
                    disabledDeviceList.add(scanResult);
                  }
                }),
              }
          });
    }
    if (disabledDeviceList.isEmpty && connectionFailedDeviceList.isEmpty) {
      dropDownData.forceClose(connectedDeviceList);
    } else {
      showErrorDialog(context, "Device was not active, Please contact admin");
      setState(() {
        connectPressed = false;
        disabledDeviceList.clear();
        connectionFailedDeviceList.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Material(
        color: const Color.fromARGB(255, 30, 41, 59),
        child: SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(flex: 6, child: Container()),
                    const Expanded(
                      flex: 2,
                      child: Divider(
                        color: Color.fromARGB(255, 220, 220, 220),
                        thickness: 4,
                      ),
                    ),
                    Expanded(flex: 6, child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dropDownData.title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    InkWell(
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onTap: () {
                        dropDownData.popupClose();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ListView.builder(
                    itemCount: dropDownData.items.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: DeviceListTile(
                            scanResult:
                                dropDownData.items.values.elementAt(index),
                            updateDeviceToList: updateSelectedDeviceList),
                      );
                    }),
                // const SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: SizedBox(
                      width: width - 20,
                      height: 60,
                      child: CupertinoButton(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: const Color.fromARGB(255, 34, 197, 94),
                          onPressed: () {
                            connect();
                          },
                          child: connectPressed
                              ? CupertinoActivityIndicator()
                              : const Text('Connect',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255))))),
                ),
              ],
            ),
          ),
        ));
  }
}
