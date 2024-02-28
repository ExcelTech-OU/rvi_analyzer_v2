import 'package:rvi_analyzer/common/key_box.dart';

class Device {
  final int id;
  final String name;
  final String macAddress;
  final String batchNo;
  final String firmwareVersion;
  final String connectedNetworkId;
  final int userId;
  final DeviceStatus status;

  const Device(
      {required this.id,
      required this.name,
      required this.macAddress,
      required this.batchNo,
      required this.firmwareVersion,
      required this.connectedNetworkId,
      required this.userId,
      required this.status});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
        id: json[idK],
        name: json[nameK],
        macAddress: json[macAddressK],
        batchNo: json[batchNoK],
        firmwareVersion: json[firmwareVersionK],
        connectedNetworkId: json[connectedNetworkIdK],
        userId: json[userIdK],
        status: DeviceStatus.values.byName(json[statusK]));
  }
}

enum DeviceStatus { ACTIVE, DISABLED }
