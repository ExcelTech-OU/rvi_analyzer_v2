import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';

@HiveType(typeId: 13)
class ModeFive extends HiveObject {
  @HiveField(0)
  final String createdBy;

  @HiveField(1)
  final DefaultConfiguration defaultConfigurations;

  @HiveField(2)
  final SessionConfigurationModeFive sessionConfigurationModeFive;

  @HiveField(3)
  final SessionResult results;

  @HiveField(4)
  final String status;

  ModeFive({
    required this.createdBy,
    required this.defaultConfigurations,
    required this.sessionConfigurationModeFive,
    required this.results,
    required this.status,
  });

  Map toJson() => {
        'createdBy': createdBy,
        'defaultConfigurations': defaultConfigurations.toJson(),
        'sessionConfigurationModeFive': sessionConfigurationModeFive.toJson(),
        'results': results,
        'status': status,
      };
}

@HiveType(typeId: 14)
class SessionConfigurationModeFive extends HiveObject {
  @HiveField(0)
  final String fixedVoltage;

  @HiveField(1)
  final String maxCurrent;

  @HiveField(2)
  final String timeDuration;

  SessionConfigurationModeFive({
    required this.fixedVoltage,
    required this.maxCurrent,
    required this.timeDuration,
  });

  Map toJson() => {
        'fixedVoltage': fixedVoltage,
        'maxCurrent': maxCurrent,
        'timeDuration': timeDuration
      };
}
