import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';

@HiveType(typeId: 15)
class ModeSix extends HiveObject {
  @HiveField(0)
  final String createdBy;

  @HiveField(1)
  final DefaultConfiguration defaultConfigurations;

  @HiveField(2)
  final SessionConfigurationModeSix sessionConfigurationModeSix;

  @HiveField(3)
  final SessionResult results;

  @HiveField(4)
  final String status;

  ModeSix({
    required this.createdBy,
    required this.defaultConfigurations,
    required this.sessionConfigurationModeSix,
    required this.results,
    required this.status,
  });

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeSix': sessionConfigurationModeSix.toJson(),
        'results': results,
        'status': status,
      };
}

@HiveType(typeId: 16)
class SessionConfigurationModeSix extends HiveObject {
  @HiveField(0)
  final String fixedCurrent;

  @HiveField(1)
  final String maxVoltage;

  @HiveField(2)
  final String timeDuration;

  SessionConfigurationModeSix({
    required this.fixedCurrent,
    required this.maxVoltage,
    required this.timeDuration,
  });

  Map toJson() => {
        'fixedCurrent': fixedCurrent,
        'maxVoltage': maxVoltage,
        'timeDuration': timeDuration
      };
}
