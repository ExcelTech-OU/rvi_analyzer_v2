import 'package:rvi_analyzer/domain/default_configuration.dart';
import 'package:rvi_analyzer/domain/session_result.dart';

class ModeFive {
  final String createdBy;
  final DefaultConfiguration defaultConfigurations;
  final SessionConfigurationModeFive sessionConfigurationModeFive;
  final SessionResult results;
  final String status;

  ModeFive(
      {required this.createdBy,
      required this.defaultConfigurations,
      required this.sessionConfigurationModeFive,
      required this.results,
      required this.status});

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeFive': sessionConfigurationModeFive.toJson(),
        'results': results,
        'status': status,
      };
}

class SessionConfigurationModeFive {
  final String fixedVoltage;
  final String maxCurrent;
  final String timeDuration;

  SessionConfigurationModeFive(
      {required this.fixedVoltage,
      required this.maxCurrent,
      required this.timeDuration});

  Map toJson() => {
        'fixedVoltage': fixedVoltage,
        'maxCurrent': maxCurrent,
        'timeDuration': timeDuration
      };
}
