import 'dart:io';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/connected_devices_info.dart';

class ConnectedDevicesInfoRepository {
  static final ConnectedDevicesInfoRepository _instance =
      ConnectedDevicesInfoRepository._internal();

  factory ConnectedDevicesInfoRepository() {
    return _instance;
  }

  ConnectedDevicesInfoRepository._internal();

  static const String _boxName = 'connected_devices_info';

  Future<Box<ConnectedDevicesInfo>> _openBox() async {
    final box = await Hive.openBox<ConnectedDevicesInfo>(_boxName);
    return box;
  }

  Future<void> addConnectedDevicesInfo(ConnectedDevicesInfo data) async {
    final box = await _openBox();
    await box.add(data);
  }

  Future<List<ConnectedDevicesInfo>> getAllConnectedDevicesInfos() async {
    final box = await _openBox();
    final connectedDeviceInfo = box.values.toList();
    return connectedDeviceInfo;
  }

  Future<ConnectedDevicesInfo?> getConnectedDevicesInfoByUserName(
      String username) async {
    final box = await _openBox();
    final connectedDevicesData = box.values.toList();

    try {
      ConnectedDevicesInfo? connectedDeviceInfo =
          connectedDevicesData.firstWhere((p) => p.username == username);
      return connectedDeviceInfo;
    } catch (error) {
      return null;
    }
  }

  Future<void> addDeviceByUserName(String username, ScanResult result) async {
    final box = await _openBox();
    final connectedDeviceInfo =
        await getConnectedDevicesInfoByUserName(username);
    if (connectedDeviceInfo != null) {
      if (!connectedDeviceInfo.devicesMacs.contains(
          Platform.isAndroid ? result.device.id.id : result.device.name)) {
        connectedDeviceInfo.devicesMacs
            .add(Platform.isAndroid ? result.device.id.id : result.device.name);
      }
      await box.delete(connectedDeviceInfo.key);
      await box.add(connectedDeviceInfo);
    } else {
      await box.add(ConnectedDevicesInfo(username,
          [Platform.isAndroid ? result.device.id.id : result.device.name]));
    }
  }

  Future<void> removeByName(String username, ScanResult result) async {
    final box = await _openBox();
    final connectedDeviceInfo =
        await getConnectedDevicesInfoByUserName(username);
    if (connectedDeviceInfo != null) {
      if (connectedDeviceInfo.devicesMacs.contains(
          Platform.isAndroid ? result.device.id.id : result.device.name)) {
        connectedDeviceInfo.devicesMacs.remove(
            Platform.isAndroid ? result.device.id.id : result.device.name);
      }
      await box.delete(connectedDeviceInfo.key);
      await box.add(connectedDeviceInfo);
    }
  }

  Future<void> closeBox() async {
    final box = await _openBox();
    await box.close();
  }
}
