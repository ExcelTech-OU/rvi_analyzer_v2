import 'package:hive/hive.dart';

class DefaultConfiguration {
  final String customerName;

  final String operatorId;

  final String batchNo;

  final String serialNo;

  final String sessionId;

  DefaultConfiguration({
    required this.customerName,
    required this.operatorId,
    required this.batchNo,
    required this.serialNo,
    required this.sessionId,
  });

  Map toJson() => {
        'customerName': customerName,
        'operatorId': operatorId,
        'batchNo': batchNo,
        'serialNo': serialNo,
        'sessionId': sessionId,
      };

  factory DefaultConfiguration.fromJson(Map<String, dynamic> json) {
    return DefaultConfiguration(
      customerName: json['customerName'] as String,
      operatorId: json['operatorId'] as String,
      batchNo: json['batchNo'] as String,
      serialNo: json['serialNo'] as String,
      sessionId: json['sessionId'] as String,
    );
  }
}

class SessionResult {
  final String testId;

  final List<Reading> readings;

  SessionResult({
    required this.testId,
    required this.readings,
  });

  Map toJson() => {'testId': testId, 'readings': readings};

  factory SessionResult.fromJson(Map<String, dynamic> json) {
    List<dynamic> readingsList = json['readings'] as List<dynamic>;
    List<Reading> readings = readingsList
        .map((readingJson) => Reading.fromJson(readingJson))
        .toList();

    return SessionResult(
      testId: json['testId'] as String,
      readings: readings,
    );
  }
}

class Reading {
  final String temperature;

  final String current;

  final String voltage;

  final String? result;

  final String? readAt;

  Reading({
    required this.temperature,
    required this.current,
    required this.voltage,
    this.result,
    this.readAt,
  });

  Map toJson() => {
        'temperature': temperature,
        'current': current,
        'voltage': voltage,
        'result': result,
        'readAt': readAt,
      };

  factory Reading.fromJson(Map<String, dynamic> json) {
    return Reading(
      temperature: json['temperature'] as String,
      current: json['current'] as String,
      voltage: json['voltage'] as String,
      result: json['result'] as String?,
      readAt: json['readAt'] as String?,
    );
  }
}
