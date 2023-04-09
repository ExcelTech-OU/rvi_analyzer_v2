import 'package:rvi_analyzer/main.dart';
import 'package:rvi_analyzer/providers/connected_devices_provider.dart';
import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/views/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BluetoothDisconnectionState {
  static bool closeDialog = false;

  static void showAlertDialog(WidgetRef ref) {
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
              children: const [
                Text('Bluetooth turn off',
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                SizedBox(
                  height: 10,
                ),
                Text('Please check the Bluetooth connection status',
                    style: TextStyle(color: Colors.black, fontSize: 13)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                ref.read(deviceManagementState).removeAllConnectDevices();
                deviceDataMap = {};
                deviceConnectionStatusMap = {};
                if (closeDialog) {
                  ref.read(deviceManagementState).removeAllConnectDevices();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardPage(
                                initialIndex: 1,
                              )));
                } else {
                  Navigator.pop(context);
                  showAlertDialog(ref);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
