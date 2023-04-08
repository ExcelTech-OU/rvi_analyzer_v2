import 'package:rvi_analyzer/domain/default_configuration.dart';
import 'package:rvi_analyzer/domain/session_result.dart';

class ModeThree {
  final String createdBy;
  final DefaultConfiguration defaultConfigurations;
  final SessionConfigurationModeThree sessionConfigurationModeThree;
  final SessionResult results;
  final String status;

  ModeThree(
      {required this.createdBy,
      required this.defaultConfigurations,
      required this.sessionConfigurationModeThree,
      required this.results,
      required this.status});

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeThree': sessionConfigurationModeThree.toJson(),
        'results': results,
        'status': status,
      };
}

class SessionConfigurationModeThree {
  final String startingVoltage;
  final String desiredVoltage;
  final String maxCurrent;
  final String voltageResolution;
  final String chargeInTime;

  SessionConfigurationModeThree(
      {required this.startingVoltage,
      required this.desiredVoltage,
      required this.maxCurrent,
      required this.voltageResolution,
      required this.chargeInTime});

  Map toJson() => {
        'startingVoltage': startingVoltage,
        'desiredVoltage': desiredVoltage,
        'maxCurrent': maxCurrent,
        'voltageResolution': voltageResolution,
        'chargeInTime': chargeInTime
      };
}
