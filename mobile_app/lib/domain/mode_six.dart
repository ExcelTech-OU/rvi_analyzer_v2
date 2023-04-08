import 'package:rvi_analyzer/domain/default_configuration.dart';
import 'package:rvi_analyzer/domain/session_result.dart';

class ModeSix {
  final String createdBy;
  final DefaultConfiguration defaultConfigurations;
  final SessionConfigurationModeSix sessionConfigurationModeSix;
  final SessionResult results;
  final String status;

  ModeSix(
      {required this.createdBy,
      required this.defaultConfigurations,
      required this.sessionConfigurationModeSix,
      required this.results,
      required this.status});

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeSix': sessionConfigurationModeSix.toJson(),
        'results': results,
        'status': status,
      };
}

class SessionConfigurationModeSix {
  final String fixedCurrent;
  final String maxVoltage;
  final String timeDuration;

  SessionConfigurationModeSix(
      {required this.fixedCurrent,
      required this.maxVoltage,
      required this.timeDuration});

  Map toJson() => {
        'fixedCurrent': fixedCurrent,
        'maxVoltage': maxVoltage,
        'timeDuration': timeDuration
      };
}
