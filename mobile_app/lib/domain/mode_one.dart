import 'package:rvi_analyzer/domain/default_configuration.dart';
import 'package:rvi_analyzer/domain/session_result.dart';

class ModeOne {
  final String createdBy;
  final DefaultConfiguration defaultConfigurations;
  final SessionConfigurationModeOne sessionConfigurationModeOne;
  final List<SessionResult> results;
  final String status;

  ModeOne(
      {required this.createdBy,
      required this.defaultConfigurations,
      required this.sessionConfigurationModeOne,
      required this.results,
      required this.status});

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeOne': sessionConfigurationModeOne.toJson(),
        'results': results,
        'status': status,
      };
}

class SessionConfigurationModeOne {
  final String voltage;
  final String maxCurrent;
  final String passMinCurrent;
  final String passMaxCurrent;

  SessionConfigurationModeOne(
      {required this.voltage,
      required this.maxCurrent,
      required this.passMinCurrent,
      required this.passMaxCurrent});

  Map toJson() => {
        'voltage': voltage,
        'maxCurrent': maxCurrent,
        'passMinCurrent': passMinCurrent,
        'passMaxCurrent': passMaxCurrent
      };
}
