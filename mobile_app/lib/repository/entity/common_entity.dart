import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class DefaultConfiguration extends HiveObject {
  @HiveField(0)
  final String customerName;

  @HiveField(1)
  final String operatorId;

  @HiveField(2)
  final String batchNo;

  @HiveField(3)
  final String serialNo;

  @HiveField(4)
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
}

@HiveType(typeId: 5)
class SessionResult extends HiveObject {
  @HiveField(0)
  final String testId;

  @HiveField(1)
  final List<Reading> readings;

  SessionResult({
    required this.testId,
    required this.readings,
  });

  Map toJson() => {'testId': testId, 'readings': readings};
}

@HiveType(typeId: 6)
class Reading extends HiveObject {
  @HiveField(0)
  final String temperature;

  @HiveField(1)
  final String current;

  @HiveField(2)
  final String voltage;

  @HiveField(3)
  final String? result;

  @HiveField(4)
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
}
