import 'dart:collection';

import 'package:rvi_analyzer/domain/configure_data.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Blue {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  HashMap<String, ScanResult> blueDeviceList = HashMap();

  Future<HashMap<String, ScanResult>> scanDevices() {
    blueDeviceList = HashMap();
    flutterBlue.startScan(timeout: const Duration(seconds: 5));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name.isNotEmpty) {
          blueDeviceList.putIfAbsent(r.device.name, () => r);
        }
      }
    });

    flutterBlue.stopScan();

    return Future.delayed(
      const Duration(seconds: 6),
      () => blueDeviceList,
    );
  }

  Stream<List<ScanResult>> scanDevicesNew() {
    blueDeviceList = HashMap();
    // Start scanning
    flutterBlue.startScan(timeout: const Duration(seconds: 10));

    // Listen to scan results
    return flutterBlue.scanResults;
    // return blueDeviceList;
  }

  Future<bool> write(BluetoothDevice device, List<int> data, String ServiceUUID,
      String charUUID) async {
    bool response = false;
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        if (service.uuid.toString() == ServiceUUID) {
          for (var element in service.characteristics) {
            if (element.uuid.toString() == charUUID) {
              await element
                  .write(data)
                  .then((value) => response = true)
                  .onError((error, stackTrace) => response = false);
            }
          }
        }
      }
    } catch (e) {
      return false;
    }
    return response;
  }

  Future<bool> stop(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0001001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0001001-0451-4000-b000-000000000000") {
            await element
                .write([0x01, 0x00, 0x00])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  Future<bool> forceStop(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0001001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0001002-0451-4000-b000-000000000000") {
            await element
                .write([0x02, 0x00, 0x00])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  Future<bool> run(BluetoothDevice device, TreatmentConfig config) async {
    List<BluetoothService> services = await device.discoverServices();
    int ledVal = config.ledState ? 1 : 0;
    int time = int.parse(config.time) * 60;
    int remainingTime = time - ((time / 255).truncate() * 255);
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0000001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0000002-0451-4000-b000-000000000000") {
            await element
                .write([
                  config.protocolId + 1,
                  getTemValue(config.temp),
                  (time / 255).truncate(),
                  remainingTime,
                  ledVal,
                  3
                ])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  int getTemValue(String val) {
    if (val == "LOW") {
      return 35;
    } else if (val == "MEDIUM") {
      return 40;
    } else {
      return 45;
    }
  }

  Future<bool> pause(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0003001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0003001-0451-4000-b000-000000000000") {
            await element
                .write([0x01, 0x00])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  Future<bool> calibrate(BluetoothDevice device, int data) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0005001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0005001-0451-4000-b000-000000000000") {
            await element
                .write([data])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  Future<bool> ack(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f000000f-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0000001-0451-4000-b000-000000000000") {
            await element
                .write([0x00, 0x00, 0x00, 0x00])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  Future<bool> runNotify(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f000ffc0-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f000ffc0-0451-4000-b000-000000000000") {
            await element.setNotifyValue(true);
            element.value.listen((value) {
              print(value);
            });
          }
        }
      }
    }
    return response;
  }
}
