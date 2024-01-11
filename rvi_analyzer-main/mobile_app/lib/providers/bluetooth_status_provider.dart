import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceBluetoothState =
    ChangeNotifierProvider<BluetoothStatus>((ref) => BluetoothStatus());

class BluetoothStatus extends ChangeNotifier {
  String state = "";

  void activeNotifyStreamListener() {
    FlutterBluePlus.instance.state.listen((state) {
      this.state = state.toString(); // Use state.toString() for compatibility
      notifyListeners();
    });
  }
}
