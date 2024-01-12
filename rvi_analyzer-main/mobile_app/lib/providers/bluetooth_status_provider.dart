import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceBluetoothState =
    ChangeNotifierProvider<BluetoothStatus>((ref) => BluetoothStatus());

class BluetoothStatus extends ChangeNotifier {
  String state = "";
  bool alreadyListening = false;

  void activeNotifyStreamListener() {
    if (!alreadyListening) {
      FlutterBluePlus.state.listen((event) {
        state = event.name;
        alreadyListening = true;

        //   })
        // }
        // FlutterBluePlus.instance.state.listen((state) {
        //   this.state = state.toString(); // Use state.toString() for compatibility
        notifyListeners();
      });
    }
  }
}
