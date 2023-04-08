import 'package:rvi_analyzer/domain/default_configuration.dart';
import 'package:rvi_analyzer/domain/session_result.dart';

class ModeTwo {
  final String createdBy;
  final DefaultConfiguration defaultConfigurations;
  final SessionConfigurationModeTwo sessionConfigurationModeTwo;
  final List<SessionResult> results;
  final String status;

  ModeTwo(
      {required this.createdBy,
      required this.defaultConfigurations,
      required this.sessionConfigurationModeTwo,
      required this.results,
      required this.status});

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeTwo': sessionConfigurationModeTwo.toJson(),
        'results': results,
        'status': status,
      };
}

class SessionConfigurationModeTwo {
  final String current;
  final String maxVoltage;
  final String passMinVoltage;
  final String passMaxVoltage;

  SessionConfigurationModeTwo(
      {required this.current,
      required this.maxVoltage,
      required this.passMinVoltage,
      required this.passMaxVoltage});

  Map toJson() => {
        'current': current,
        'maxVoltage': maxVoltage,
        'passMinVoltage': passMinVoltage,
        'passMaxVoltage': passMaxVoltage
      };
}
