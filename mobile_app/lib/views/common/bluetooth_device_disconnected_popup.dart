import 'package:rvi_analyzer/main.dart';
import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/views/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BluetoothDeviceDisconnectedPopup {
  static bool closeDialog = false;

  static void showAlertDialog(WidgetRef ref, ScanResult scanResult) {
    showCupertinoModalPopup<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) => Theme(
        data: ThemeData.dark(),
        child: AlertDialog(
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          elevation: 24,
          title: Center(
            child: Column(
              children: [
                Text('${scanResult.device.name} is disconnected',
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
                const Text('Please reconnect again',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
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
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ref
                            .read(deviceManagementState)
                            .removeDevice(scanResult);
                        ref
                            .read(
                                deviceDataMap[scanResult.device.name]!.notifier)
                            .setTreatmentConfig(null);
                        if (deviceConnectionStatusMap
                            .containsKey(scanResult.device.name)) {
                          ref
                              .read(deviceConnectionStatusMap[
                                      scanResult.device.name]!
                                  .notifier)
                              .alreadyListening = false;
                          ref
                              .read(deviceConnectionStatusMap[
                                      scanResult.device.name]!
                                  .notifier)
                              .cancelSubscription();
                          deviceConnectionStatusMap
                              .remove(scanResult.device.name);
                        }
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardPage(
                                      initialIndex: 1,
                                    )));
                      },
                      child: const Icon(
                        Icons.cancel_rounded,
                        color: Color.fromARGB(255, 148, 163, 184),
                        size: 45,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
