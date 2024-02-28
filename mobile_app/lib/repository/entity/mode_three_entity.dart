import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';

@HiveType(typeId: 9)
class ModeThree extends HiveObject {
  @HiveField(0)
  final String createdBy;

  @HiveField(1)
  final DefaultConfiguration defaultConfigurations;

  @HiveField(2)
  final SessionConfigurationModeThree sessionConfigurationModeThree;

  @HiveField(3)
  final SessionResult results;

  @HiveField(4)
  final String status;

  ModeThree({
    required this.createdBy,
    required this.defaultConfigurations,
    required this.sessionConfigurationModeThree,
    required this.results,
    required this.status,
  });

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeThree': sessionConfigurationModeThree.toJson(),
        'results': results,
        'status': status,
      };

  factory ModeThree.fromJson(Map<String, dynamic> json) {
    return ModeThree(
      createdBy: json['createdBy'] as String,
      defaultConfigurations:
          DefaultConfiguration.fromJson(json['defaultConfigurations']),
      sessionConfigurationModeThree: SessionConfigurationModeThree.fromJson(
          json['sessionConfigurationModeThree']),
      results: SessionResult.fromJson(json['results']),
      status: json['status'] as String,
    );
  }
}

@HiveType(typeId: 10)
class SessionConfigurationModeThree extends HiveObject {
  @HiveField(0)
  final String startingVoltage;

  @HiveField(1)
  final String desiredVoltage;

  @HiveField(2)
  final String maxCurrent;

  @HiveField(3)
  final String voltageResolution;

  @HiveField(4)
  final String chargeInTime;

  SessionConfigurationModeThree({
    required this.startingVoltage,
    required this.desiredVoltage,
    required this.maxCurrent,
    required this.voltageResolution,
    required this.chargeInTime,
  });

  Map toJson() => {
        'startingVoltage': startingVoltage,
        'desiredVoltage': desiredVoltage,
        'maxCurrent': maxCurrent,
        'voltageResolution': voltageResolution,
        'chargeInTime': chargeInTime
      };

  factory SessionConfigurationModeThree.fromJson(Map<String, dynamic> json) {
    return SessionConfigurationModeThree(
      startingVoltage: json['startingVoltage'] as String,
      desiredVoltage: json['desiredVoltage'] as String,
      maxCurrent: json['maxCurrent'] as String,
      voltageResolution: json['voltageResolution'] as String,
      chargeInTime: json['chargeInTime'] as String,
    );
  }
}
