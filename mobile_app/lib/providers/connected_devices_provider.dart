import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceManagementState = ChangeNotifierProvider<ConnectedDevicesProvider>(
    (ref) => ConnectedDevicesProvider());

class ConnectedDevicesProvider extends ChangeNotifier {
  HashMap<String, ScanResult> connectedBlueDeviceList = HashMap();

  HashMap<String, ScanResult> availableDeviceList = HashMap();

  HashMap<String, ScanResult> get connectedDevices => connectedBlueDeviceList;

  HashMap<String, ScanResult> get availableDevices => availableDeviceList;

  int get connectedDeviceCount => connectedBlueDeviceList.length;

  void addDevice(ScanResult scanResult) {
    print(connectedBlueDeviceList);
    connectedBlueDeviceList.putIfAbsent(
        scanResult.device.name, () => scanResult);
    availableDeviceList.clear();
    notifyListeners();
  }

  void updateAvailable(ScanResult scanResult) {
    if (availableDeviceList.containsKey(scanResult.device.name)) {
      availableDeviceList.remove(scanResult.device.name);
    }
    notifyListeners();
  }

  void clearAvailableDeviceList() {
    availableDeviceList.clear();
    notifyListeners();
  }

  void removeDevice(ScanResult scanResult) {
    connectedBlueDeviceList.remove(scanResult.device.name);
    notifyListeners();
  }

  void addAvailableDevice(HashMap<String, ScanResult> scanResults) {
    connectedBlueDeviceList.forEach((key, value) {
      if (scanResults.containsKey(key)) {
        scanResults.remove(key);
      }
    });
    print(scanResults);
    availableDeviceList.clear();
    availableDeviceList = scanResults;
    notifyListeners();
  }

  Future<void> removeAllConnectDevices() async {
    List<ScanResult> allDevices = connectedBlueDeviceList.values.toList();
    for (ScanResult scanResult in allDevices) {
      await disconnectDevice(scanResult);
    }
    notifyListeners();
  }

  Future<void> disconnectDevice(ScanResult scanResult) async {
    await scanResult.device
        .disconnect()
        .then((value) => {removeDevice(scanResult)})
        .onError(
            (error, stackTrace) => {print("Error while disconnecting$error")});
  }
}
