import 'dart:collection';

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

  Future<HashMap<String, ScanResult>> scanDevicesWithFilters(String filter) {
    blueDeviceList = HashMap();
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name.isNotEmpty) {
          if (r.device.name.toLowerCase().contains(filter.toLowerCase())) {
            blueDeviceList.putIfAbsent(r.device.name, () => r);
          }
        }
      }
    });

    flutterBlue.stopScan();

    return Future.delayed(
      const Duration(seconds: 4),
      () => blueDeviceList,
    );
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
              "f0001001-0451-4000-b000-000000000000") {
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

  Future<bool> runMode01(
      BluetoothDevice device, int fixedVoltage, int current) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0002001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0002001-0451-4000-b000-000000000000") {
            await element
                .write([
                  0x01,
                  0x01,
                  fixedVoltage,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  (current / 255).truncate(),
                  current - (current / 255).truncate() * 255,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00
                ])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  Future<bool> runMode02(
      BluetoothDevice device, int fixedCurrent, int voltage) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0002001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0002001-0451-4000-b000-000000000000") {
            await element
                .write([
                  0x01,
                  0x02,
                  0x00,
                  voltage,
                  0x00,
                  0x00,
                  (fixedCurrent / 255).truncate(),
                  fixedCurrent - (fixedCurrent / 255).truncate() * 255,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00
                ])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  Future<bool> runMode03(
      BluetoothDevice device,
      int startingVoltage,
      int desiredVoltage,
      int maxCurrent,
      int voltageResolution,
      int chargeInTime) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0002001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0002001-0451-4000-b000-000000000000") {
            await element
                .write([
                  0x01,
                  0x03,
                  0x00,
                  0x00,
                  startingVoltage,
                  desiredVoltage,
                  0x00,
                  0x00,
                  (maxCurrent / 255).truncate(),
                  maxCurrent - (maxCurrent / 255).truncate() * 255,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  voltageResolution,
                  0x00,
                  0x00,
                  chargeInTime,
                  0x00
                ])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  Future<bool> runMode04(
      BluetoothDevice device,
      int startingCurrent,
      int desiredCurrent,
      int maxVoltage,
      int currentResolution,
      int chargeInTime) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0002001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0002001-0451-4000-b000-000000000000") {
            await element
                .write([
                  0x01,
                  0x04,
                  0x00,
                  maxVoltage,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  (startingCurrent / 255).truncate(),
                  startingCurrent - (startingCurrent / 255).truncate() * 255,
                  (desiredCurrent / 255).truncate(),
                  desiredCurrent - (desiredCurrent / 255).truncate() * 255,
                  0x00,
                  0x00,
                  (currentResolution / 255).truncate(),
                  currentResolution -
                      (currentResolution / 255).truncate() * 255,
                  chargeInTime,
                  0x00
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

  Future<bool> runMode05(BluetoothDevice device, int fixedVoltage,
      int maxCurrent, int timeDuration) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0002001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0002001-0451-4000-b000-000000000000") {
            await element
                .write([
                  0x01,
                  0x05,
                  fixedVoltage,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  (maxCurrent / 255).truncate(),
                  maxCurrent - (maxCurrent / 255).truncate() * 255,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  timeDuration,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00
                ])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  Future<bool> runMode06(BluetoothDevice device, int fixedCurrent,
      int maxVoltage, int timeDuration) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0002001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0002001-0451-4000-b000-000000000000") {
            await element
                .write([
                  0x01,
                  0x06,
                  0x00,
                  maxVoltage,
                  0x00,
                  0x00,
                  (fixedCurrent / 255).truncate(),
                  fixedCurrent - (fixedCurrent / 255).truncate() * 255,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  timeDuration,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00
                ])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }

  Future<bool> runMode07(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    bool response = false;
    for (var service in services) {
      if (service.uuid.toString() == "f0002001-0451-4000-b000-000000000000") {
        for (var element in service.characteristics) {
          if (element.uuid.toString() ==
              "f0002001-0451-4000-b000-000000000000") {
            await element
                .write([
                  0x01,
                  0x07,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00,
                  0x00
                ])
                .then((value) => response = true)
                .onError((error, stackTrace) => response = false);
          }
        }
      }
    }
    return response;
  }
}
