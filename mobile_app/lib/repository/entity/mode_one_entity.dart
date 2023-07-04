import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';

@HiveType(typeId: 2)
class ModeOne extends HiveObject {
  @HiveField(0)
  final String createdBy;

  @HiveField(1)
  final DefaultConfiguration defaultConfigurations;

  @HiveField(2)
  final SessionConfigurationModeOne sessionConfigurationModeOne;

  @HiveField(3)
  final List<SessionResult> results;

  @HiveField(4)
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
}

@HiveType(typeId: 3)
class SessionConfigurationModeOne extends HiveObject {
  @HiveField(0)
  final String voltage;

  @HiveField(1)
  final String maxCurrent;

  @HiveField(2)
  final String passMinCurrent;

  @HiveField(3)
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
}
