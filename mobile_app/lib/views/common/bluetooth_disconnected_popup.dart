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
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          elevation: 24,
          title: Center(
            child: Column(
              children: const [
                Text('Bluetooth turn off',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                SizedBox(
                  height: 10,
                ),
                Text('Please check the Bluetooth connection status',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
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
                            .removeAllConnectDevices();
                        deviceDataMap = {};
                        deviceConnectionStatusMap = {};
                        if (closeDialog) {
                          ref
                              .read(deviceManagementState)
                              .removeAllConnectDevices();
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
