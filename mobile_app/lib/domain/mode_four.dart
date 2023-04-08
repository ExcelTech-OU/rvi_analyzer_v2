import 'package:rvi_analyzer/domain/default_configuration.dart';
import 'package:rvi_analyzer/domain/session_result.dart';

class ModeFour {
  final String createdBy;
  final DefaultConfiguration defaultConfigurations;
  final SessionConfigurationModeFour sessionConfigurationModeFour;
  final SessionResult results;
  final String status;

  ModeFour(
      {required this.createdBy,
      required this.defaultConfigurations,
      required this.sessionConfigurationModeFour,
      required this.results,
      required this.status});

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeFour': sessionConfigurationModeFour.toJson(),
        'results': results,
        'status': status,
      };
}

class SessionConfigurationModeFour {
  final String startingCurrent;
  final String desiredCurrent;
  final String maxVoltage;
  final String currentResolution;
  final String chargeInTime;

  SessionConfigurationModeFour(
      {required this.startingCurrent,
      required this.desiredCurrent,
      required this.maxVoltage,
      required this.currentResolution,
      required this.chargeInTime});

  Map toJson() => {
        'startingCurrent': startingCurrent,
        'desiredCurrent': desiredCurrent,
        'maxVoltage': maxVoltage,
        'currentResolution': currentResolution,
        'chargeInTime': chargeInTime
      };
}
