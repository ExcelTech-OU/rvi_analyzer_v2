import 'dart:async';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rvi_analyzer/views/dashboard/device_tile_card_model.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';
import 'package:rvi_analyzer/providers/connected_devices_provider.dart';

class DeviceListPopup {
  HashMap<String, ScanResult> blueDeviceList = HashMap();
  Blue blue = Blue();

  Future<void> showMyDialog(BuildContext context) async {
    bool scanPressed = false;
    // context.read<ConnectedDevicesProvider>().removeAllAvailableDevices();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Consumer(builder: ((context, ref, child) {
            return AlertDialog(
                backgroundColor: Colors.black,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                elevation: 24.0,
                title: const Center(
                    child: Text('Available Devices',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)))),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      ref
                              .watch(deviceManagementState)
                              .availableDeviceList
                              .isEmpty
                          ? const Center(
                              child: Text('No device available',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            )
                          : Column(
                              children: [
                                const SizedBox(height: 10.0),
                                for (var scanResult in ref
                                    .watch(deviceManagementState)
                                    .availableDeviceList
                                    .values)
                                  DeviceTileCardModel(scanResult),
                              ],
                            )
                    ],
                  ),
                ),
                actions: <Widget>[
                  SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CupertinoButton(
                                color: Colors.green,
                                disabledColor:
                                    Color.fromARGB(255, 101, 102, 100),
                                padding: const EdgeInsets.all(10),
                                onPressed: scanPressed
                                    ? null
                                    : () {
                                        setState(
                                          () => scanPressed = true,
                                        );
                                        blue.scanDevices().then((value) => {
                                              setState(() => {
                                                    scanPressed = false,
                                                  }),
                                              ref
                                                  .read(deviceManagementState)
                                                  .addAvailableDevice(value)
                                            });
                                      },
                                child: scanPressed
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.white)
                                    : const Text('Scan',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: CupertinoButton.filled(
                                padding: const EdgeInsets.all(10),
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('Cancel',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                              ),
                            ),
                          ]))
                ]);
          }));
        });
      },
    );
  }
}
