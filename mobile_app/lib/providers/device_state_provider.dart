import 'dart:async';
import 'dart:ffi';

import 'package:rvi_analyzer/domain/configure_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<String, ChangeNotifierProvider<DeviceState>> deviceDataMap = {};

class DeviceState extends ChangeNotifier {
  bool isConnected = false;
  ChangeNotifierProvider<StreamData> streamData =
      ChangeNotifierProvider((ref) => StreamData());
  String deviceName = "";
  TreatmentConfig? config;

  void setTreatmentConfig(TreatmentConfig? config) {
    this.config = config;
  }
}

class StreamData extends ChangeNotifier {
  List<int> notifyDataList = [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00];

  int currentTime = 0;
  int preTime = 0;
  int fullTime = 0;
  bool stopped = false;
  bool completed = false;
  late StreamSubscription subscription;

  List<int> get notifyData => notifyDataList;

  int get batteryLevel => notifyDataList[10];

  int get temPre => notifyDataList[7];

  int get state => notifyDataList[0];

  int get temperature => notifyDataList[8];

  int get currentProtocol => notifyDataList[1];

  double get voltage => (notifyDataList[4] * 255 + notifyDataList[5]) / 100;

  double get current => (notifyDataList[6] * 255 + notifyDataList[7]) / 1000;

  double get resistance => voltage / current;

  int get curTime => currentTime;
  int get getPreTime => preTime;
  int get getFullTime => fullTime;
  bool get isStopped => stopped;
  bool get isCompleted => completed;

  void resetData() {
    notifyDataList = [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00];
    notifyListeners();
  }

  void setStateStop() {
    stopped = true;
    notifyDataList = [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00];
    notifyListeners();
  }

  Future<void> runNotify(ScanResult scanResult) async {
    BluetoothDevice device = scanResult.device;

    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      if (service.uuid.toString() == "f0000005-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f000beef-0451-4000-b000-000000000000") {
            await element.setNotifyValue(true);
            Stream stream = element.value;
            subscription = stream.listen((value) {
              print(value);

              if (value.length > 9) {
                if (value[0] == 3) {
                  stopped = false;
                  completed = false;

                  if (preTime == 0 && currentTime == 0) {
                    preTime = currentTime = fullTime =
                        ((notifyDataList[4] * 255) + notifyDataList[5]);
                  } else if (preTime != 0) {
                    currentTime =
                        ((notifyDataList[4] * 255) + notifyDataList[5]);
                    if (preTime > currentTime) {
                      preTime = currentTime;
                    }
                  }
                } else if (value[0] == 6) {
                  // notifyDataList = value;
                  stopped = false;
                } else if ((notifyDataList[0] != 7 && notifyDataList[0] != 0) &&
                    value[0] == 7) {
                  // notifyDataList = value;
                  stopped = true;

                  currentTime = ((notifyDataList[4] * 255) + notifyDataList[5]);
                  if (preTime > currentTime) {
                    preTime = currentTime;
                  }
                } else if ((notifyDataList[0] != 7 && notifyDataList[0] != 0) &&
                    value[0] == 2) {
                  // notifyDataList = value;
                  completed = true;

                  currentTime = ((notifyDataList[4] * 255) + notifyDataList[5]);
                  if (preTime > currentTime) {
                    preTime = currentTime;
                  }
                } else if (value[0] == 1) {
                  // notifyDataList = value;
                }
                notifyDataList = value;
                notifyListeners();
              }
            });
          }
        }
      }
    }
  }
}

Map<String, ChangeNotifierProvider<BluetoothDeviceStatus>>
    deviceConnectionStatusMap = {};

class BluetoothDeviceStatus extends ChangeNotifier {
  String state = "";
  bool alreadyListening = false;
  ScanResult? scanResult;
  late StreamSubscription subscription;

  BluetoothDeviceStatus(this.scanResult);

  void activeNotifyStreamListener() {
    if (!alreadyListening) {
      subscription = scanResult!.device.state.listen((event) {
        state = event.name;
        alreadyListening = true;
        notifyListeners();
      });
    }
  }

  void cancelSubscription() {
    subscription.cancel();
  }
}
