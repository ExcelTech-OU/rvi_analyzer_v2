import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
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

  // Left pannel date

  TextEditingController customerNameController = TextEditingController();
  TextEditingController batchNoController = TextEditingController();
  TextEditingController operatorIdController = TextEditingController();
  TextEditingController sessionIdController = TextEditingController();
  TextEditingController testIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  int dropDownIndex = -1;
  //

  // Mode 1 data

  TextEditingController voltageControllerMode01 = TextEditingController();
  TextEditingController maxCurrentControllerMode01 = TextEditingController();
  TextEditingController minCurrentRangeControllerMode01 =
      TextEditingController();
  TextEditingController maxCurrentRangeControllerMode01 =
      TextEditingController();

  TextEditingController currentReadingVoltageControllerMode01 =
      TextEditingController();
  TextEditingController currentReadingTemControllerMode01 =
      TextEditingController();
  TextEditingController currentReadingResistanceControllerMode01 =
      TextEditingController();

  bool started = false;
  bool mode01SaveClicked = false;
  bool mode01Passed = false;

  void updateStatus() {
    notifyListeners();
  }

  //=========================

  // Mode 02 data

  TextEditingController currentControllerMode02 = TextEditingController();
  TextEditingController maxVoltageControllerMode02 = TextEditingController();
  TextEditingController minVoltageRangeControllerMode02 =
      TextEditingController();
  TextEditingController maxVoltageRangeControllerMode02 =
      TextEditingController();

  TextEditingController currentReadingCurrentControllerMode02 =
      TextEditingController();
  TextEditingController currentReadingTemControllerMode02 =
      TextEditingController();
  TextEditingController currentReadingResistanceControllerMode02 =
      TextEditingController();

  bool saveClickedMode02 = false;
  bool passedMode02 = false;

  //===================

  // Mode 03 data

  TextEditingController startingVoltageControllerMode03 =
      TextEditingController();
  TextEditingController desiredVoltageControllerMode03 =
      TextEditingController();
  TextEditingController maxCurrentControllerMode03 = TextEditingController();
  TextEditingController voltageResolutionControllerMode03 =
      TextEditingController();
  TextEditingController changeInTimeControllerMode03 = TextEditingController();

  bool saveClickedMode03 = false;
  bool passedMode03 = false;
  bool isNotInitialMode03 = false;

  // voltage vs current graph

  double xMaxGraph01Mode03 = 0.0;
  double yMaxGraph01Mode03 = 0.0;
  List<FlSpot> spotDataGraph01Mode03 = [];
  double lastVoltageMode03 = 0.0;

  double xMaxGraph02Mode03 = 0.0;
  double yMaxGraph02Mode03 = 0.0;
  List<FlSpot> spotDataGraph02Mode03 = [];

  //==============

  // Mode 04 data
  TextEditingController startingCurrentControllerMode04 =
      TextEditingController();
  TextEditingController desiredCurrentControllerMode04 =
      TextEditingController();
  TextEditingController maxVoltageControllerMode04 = TextEditingController();
  TextEditingController currentResolutionControllerMode04 =
      TextEditingController();
  TextEditingController changeInTimeControllerMode04 = TextEditingController();

  bool saveClickedMode04 = false;
  bool passedMode04 = false;
  bool isNotInitialMode04 = false;

  double xMaxGraph01Mode04 = 0.0;
  double yMaxGraph01Mode04 = 0.0;
  List<FlSpot> spotDataGraph01Mode04 = [];
  double lastVoltageMode04 = 0.0;

  double xMaxGraph02Mode04 = 0.0;
  double yMaxGraph02Mode04 = 0.0;
  List<FlSpot> spotDataGraph02Mode04 = [];

  //=====

  // Mode 05 data
  TextEditingController fixedVoltageControllerMode05 = TextEditingController();
  TextEditingController maxCurrentControllerMode05 = TextEditingController();
  TextEditingController timeDurationControllerMode05 = TextEditingController();

  bool saveClickedMode05 = false;
  bool passedMode05 = false;
  bool isNotInitialMode05 = false;

  double timeMode05 = 0;
  double xMaxGraph01Mode05 = 10;
  double yMaxGraph01Mode05 = 0.0;
  List<FlSpot> spotDataGraph01Mode05 = [];
  double lastVoltageMode05 = 0.0;

  double xMaxGraph02Mode05 = 0.0;
  double yMaxGraph02Mode05 = 0.0;
  List<FlSpot> spotDataGraph02Mode05 = [];

  double xMaxGraph03Mode05 = 1;
  double yMaxGraph03Mode05 = 0.0;
  List<FlSpot> spotDataGraph03Mode05 = [];

  //=====

  // Mode 06 data
  TextEditingController fixedCurrentControllerMode06 = TextEditingController();
  TextEditingController timeDurationControllerMode06 = TextEditingController();
  TextEditingController maxVoltageControllerMode06 = TextEditingController();

  double timeMode06 = 0;

  bool saveClickedMode06 = false;
  bool passedMode06 = false;
  bool isNotInitialMode06 = false;

  double xMaxGraph01Mode06 = 0.0;
  double yMaxGraph01Mode06 = 0.0;
  List<FlSpot> spotDataGraph01Mode06 = [];
  double lastVoltageMode06 = 0.0;

  double xMaxGraph02Mode06 = 0.0;
  double yMaxGraph02Mode06 = 0.0;
  List<FlSpot> spotDataGraph02Mode06 = [];

  double xMaxGraph03Mode06 = 0.0;
  double yMaxGraph03Mode06 = 0.0;
  List<FlSpot> spotDataGraph03Mode06 = [];

  //=====

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
    print("gsfgdfgdfgdfg");
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
