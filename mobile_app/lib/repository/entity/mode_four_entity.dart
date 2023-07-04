import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';

@HiveType(typeId: 11)
class ModeFour extends HiveObject {
  @HiveField(0)
  final String createdBy;

  @HiveField(1)
  final DefaultConfiguration defaultConfigurations;

  @HiveField(2)
  final SessionConfigurationModeFour sessionConfigurationModeFour;

  @HiveField(3)
  final SessionResult results;

  @HiveField(4)
  final String status;

  ModeFour({
    required this.createdBy,
    required this.defaultConfigurations,
    required this.sessionConfigurationModeFour,
    required this.results,
    required this.status,
  });

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeFour': sessionConfigurationModeFour.toJson(),
        'results': results,
        'status': status,
      };
}

@HiveType(typeId: 12)
class SessionConfigurationModeFour extends HiveObject {
  @HiveField(0)
  final String startingCurrent;

  @HiveField(1)
  final String desiredCurrent;

  @HiveField(2)
  final String maxVoltage;

  @HiveField(3)
  final String currentResolution;

  @HiveField(4)
  final String chargeInTime;

  SessionConfigurationModeFour({
    required this.startingCurrent,
    required this.desiredCurrent,
    required this.maxVoltage,
    required this.currentResolution,
    required this.chargeInTime,
  });

  Map toJson() => {
        'startingCurrent': startingCurrent,
        'desiredCurrent': desiredCurrent,
        'maxVoltage': maxVoltage,
        'currentResolution': currentResolution,
        'chargeInTime': chargeInTime
      };
}
