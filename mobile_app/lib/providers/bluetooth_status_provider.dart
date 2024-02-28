import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceBluetoothState =
    ChangeNotifierProvider<BluetoothStatus>((ref) => BluetoothStatus());

class BluetoothStatus extends ChangeNotifier {
  String state = "";

  void activeNotifyStreamListener() {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    flutterBlue.state.listen((event) {
      state = event.name;
      notifyListeners();
    });
  }
}
