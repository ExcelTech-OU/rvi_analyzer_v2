import 'package:rvi_analyzer/common/key_box.dart';

class Heater {
  final int id;
  final String batchNo;
  final double manufacturedResistance;
  final double currentResistance;
  final int deviceId;
  final int userId;
  final String connectedStatus;

  const Heater(
      {required this.id,
      required this.batchNo,
      required this.manufacturedResistance,
      required this.currentResistance,
      required this.deviceId,
      required this.userId,
      required this.connectedStatus});

  factory Heater.fromJson(Map<String, dynamic> json) {
    return Heater(
        id: json[idK],
        batchNo: json[batchNoK],
        manufacturedResistance: json[manufacturedResistanceK],
        currentResistance: json[currentResistanceK],
        deviceId: json[deviceIdK],
        userId: json[userIdK],
        connectedStatus: json[connectedStatusK]);
  }
}
