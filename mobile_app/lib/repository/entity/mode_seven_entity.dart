import 'package:rvi_analyzer/repository/entity/common_entity.dart';

class ModeSeven {
  final String createdBy;

  final DefaultConfiguration defaultConfigurations;

  final SessionResultModeSeven result;

  final String status;

  ModeSeven({
    required this.createdBy,
    required this.defaultConfigurations,
    required this.result,
    required this.status,
  });

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'result': result.toJson(),
        'status': status,
      };

  factory ModeSeven.fromJson(Map<String, dynamic> json) {
    return ModeSeven(
      createdBy: json['createdBy'] as String,
      defaultConfigurations:
          DefaultConfiguration.fromJson(json['defaultConfigurations']),
      result: SessionResultModeSeven.fromJson(json['result']),
      status: json['status'] as String,
    );
  }
}

class SessionResultModeSeven {
  final String testId;

  final SessionSevenReading reading;

  SessionResultModeSeven({
    required this.testId,
    required this.reading,
  });

  Map toJson() => {'testId': testId, 'reading': reading.toJson()};

  factory SessionResultModeSeven.fromJson(Map<String, dynamic> json) {
    return SessionResultModeSeven(
      testId: json['testId'] as String,
      reading: SessionSevenReading.fromJson(json['reading']),
    );
  }
}

class SessionSevenReading {
  final String macAddress;
  final String current;
  final String voltage;
  final String resistance;
  final String productionOrder;
  final String? result;
  final String? readAt;
  final String? currentResult;

  SessionSevenReading({
    required this.macAddress,
    required this.current,
    required this.voltage,
    required this.resistance,
    required this.productionOrder,
    this.result,
    this.readAt,
    this.currentResult,
  });

  Map toJson() => {
        'macAddress': macAddress,
        'current': current,
        'voltage': voltage,
        'resistance': resistance,
        'productionOrder': productionOrder,
        'result': result,
        'readAt': readAt,
        'currentResult': currentResult,
      };

  factory SessionSevenReading.fromJson(Map<String, dynamic> json) {
    return SessionSevenReading(
      macAddress: json['macAddress'] as String,
      current: json['current'] as String,
      voltage: json['voltage'] as String,
      resistance: json['resistance'] as String,
      productionOrder: json['productionOrder'] as String,
      result: json['result'] as String?,
      readAt: json['readAt'] as String?,
      currentResult: json['currentResult'] as String?,
    );
  }
}
