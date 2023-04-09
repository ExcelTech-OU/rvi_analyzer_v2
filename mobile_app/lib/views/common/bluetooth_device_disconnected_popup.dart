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
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          elevation: 24,
          title: Center(
            child: Column(
              children: [
                Text('${scanResult.device.name} is disconnected',
                    style: const TextStyle(color: Colors.black, fontSize: 15)),
                const Text('Please reconnect again',
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                scanResult.device.disconnect();
                ref.read(deviceManagementState).removeDevice(scanResult);
                ref
                    .read(deviceDataMap[scanResult.device.name]!.notifier)
                    .setTreatmentConfig(null);
                deviceDataMap.remove(scanResult.device.name);
                if (deviceConnectionStatusMap
                    .containsKey(scanResult.device.name)) {
                  ref
                      .read(deviceConnectionStatusMap[scanResult.device.name]!
                          .notifier)
                      .alreadyListening = false;
                  ref
                      .read(deviceConnectionStatusMap[scanResult.device.name]!
                          .notifier)
                      .cancelSubscription();
                  deviceConnectionStatusMap.remove(scanResult.device.name);
                }
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashboardPage(
                              initialIndex: 1,
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
