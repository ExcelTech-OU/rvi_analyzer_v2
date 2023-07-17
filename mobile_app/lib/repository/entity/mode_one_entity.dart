import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';

class ModeOne {
  final String createdBy;

  final DefaultConfiguration defaultConfigurations;

  final SessionConfigurationModeOne sessionConfigurationModeOne;

  final List<SessionResult> results;

  final String status;

  ModeOne({
    required this.createdBy,
    required this.defaultConfigurations,
    required this.sessionConfigurationModeOne,
    required this.results,
    required this.status,
  });

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeOne': sessionConfigurationModeOne.toJson(),
        'results': results,
        'status': status,
      };

  factory ModeOne.fromJson(Map<String, dynamic> json) {
    List<dynamic> resultsList = json['results'] as List<dynamic>;
    List<SessionResult> results = resultsList
        .map((resultJson) => SessionResult.fromJson(resultJson))
        .toList();

    return ModeOne(
      createdBy: json['createdBy'] as String,
      defaultConfigurations:
          DefaultConfiguration.fromJson(json['defaultConfigurations']),
      sessionConfigurationModeOne: SessionConfigurationModeOne.fromJson(
          json['sessionConfigurationModeOne']),
      results: results,
      status: json['status'] as String,
    );
  }
}

class SessionConfigurationModeOne {
  final String voltage;

  final String maxCurrent;

  final String passMinCurrent;

  final String passMaxCurrent;

  SessionConfigurationModeOne({
    required this.voltage,
    required this.maxCurrent,
    required this.passMinCurrent,
    required this.passMaxCurrent,
  });

  Map toJson() => {
        'voltage': voltage,
        'maxCurrent': maxCurrent,
        'passMinCurrent': passMinCurrent,
        'passMaxCurrent': passMaxCurrent
      };

  factory SessionConfigurationModeOne.fromJson(Map<String, dynamic> json) {
    return SessionConfigurationModeOne(
      voltage: json['voltage'] as String,
      maxCurrent: json['maxCurrent'] as String,
      passMinCurrent: json['passMinCurrent'] as String,
      passMaxCurrent: json['passMaxCurrent'] as String,
    );
  }
}
