import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';

@HiveType(typeId: 7)
class ModeTwo extends HiveObject {
  @HiveField(0)
  final String createdBy;

  @HiveField(1)
  final DefaultConfiguration defaultConfigurations;

  @HiveField(2)
  final SessionConfigurationModeTwo sessionConfigurationModeTwo;

  @HiveField(3)
  final List<SessionResult> results;

  @HiveField(4)
  final String status;

  ModeTwo({
    required this.createdBy,
    required this.defaultConfigurations,
    required this.sessionConfigurationModeTwo,
    required this.results,
    required this.status,
  });

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeTwo': sessionConfigurationModeTwo.toJson(),
        'results': results,
        'status': status,
      };

  factory ModeTwo.fromJson(Map<String, dynamic> json) {
    List<dynamic> resultsList = json['results'] as List<dynamic>;
    List<SessionResult> results = resultsList
        .map((resultJson) => SessionResult.fromJson(resultJson))
        .toList();

    return ModeTwo(
      createdBy: json['createdBy'] as String,
      defaultConfigurations:
          DefaultConfiguration.fromJson(json['defaultConfigurations']),
      sessionConfigurationModeTwo: SessionConfigurationModeTwo.fromJson(
          json['sessionConfigurationModeTwo']),
      results: results,
      status: json['status'] as String,
    );
  }
}

@HiveType(typeId: 8)
class SessionConfigurationModeTwo extends HiveObject {
  @HiveField(0)
  final String current;

  @HiveField(1)
  final String maxVoltage;

  @HiveField(2)
  final String passMinVoltage;

  @HiveField(3)
  final String passMaxVoltage;

  SessionConfigurationModeTwo({
    required this.current,
    required this.maxVoltage,
    required this.passMinVoltage,
    required this.passMaxVoltage,
  });

  Map toJson() => {
        'current': current,
        'maxVoltage': maxVoltage,
        'passMinVoltage': passMinVoltage,
        'passMaxVoltage': passMaxVoltage
      };

  factory SessionConfigurationModeTwo.fromJson(Map<String, dynamic> json) {
    return SessionConfigurationModeTwo(
      current: json['current'] as String,
      maxVoltage: json['maxVoltage'] as String,
      passMinVoltage: json['passMinVoltage'] as String,
      passMaxVoltage: json['passMaxVoltage'] as String,
    );
  }
}
