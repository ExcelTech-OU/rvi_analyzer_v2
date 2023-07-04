import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/mode_five_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_four_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';

@HiveType(typeId: 17)
class ModeInfo extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  final List<ModeOne> modeOnes;

  @HiveField(1)
  final List<ModeTwo> modeTwos;

  @HiveField(1)
  final List<ModeThree> modeThrees;

  @HiveField(1)
  final List<ModeFour> modeFours;

  @HiveField(1)
  final List<ModeFive> modeFives;

  @HiveField(1)
  final List<ModeSix> modeSixs;

  ModeInfo(this.username, this.modeOnes, this.modeTwos, this.modeThrees,
      this.modeFours, this.modeFives, this.modeSixs);
}
