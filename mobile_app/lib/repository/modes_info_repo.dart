import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/mode_info.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';

class TreatmentInfoRepository {
  static final TreatmentInfoRepository _instance =
      TreatmentInfoRepository._internal();

  factory TreatmentInfoRepository() {
    return _instance;
  }

  TreatmentInfoRepository._internal();

  static const String _boxName = 'mode_info';

  Future<Box<ModeInfo>> _openBox() async {
    final box = await Hive.openBox<ModeInfo>("mode_info");
    return box;
  }

  Future<void> saveOrUpdateModeOne(String username, ModeOne modeOne) async {
    final box = await _openBox();

    final modeInfo = box.values.firstWhere((info) => info.username == username,
        orElse: () => ModeInfo(username, [], [], [], [], [], []));

    try {
      final existingModeOne = modeInfo.modeOnes.firstWhere((m) =>
          m.defaultConfigurations.sessionId ==
          modeOne.defaultConfigurations.sessionId);
      existingModeOne.results.addAll(modeOne.results);
    } catch (error) {
      modeInfo.modeOnes.add(modeOne);
    }

    await modeInfo.save();
  }

  Future<void> saveOrUpdateModeTwo(String username, ModeTwo modeTwo) async {
    final box = await _openBox();

    final modeInfo = box.values.firstWhere((info) => info.username == username,
        orElse: () => ModeInfo(username, [], [], [], [], [], []));

    try {
      final existingModeTwo = modeInfo.modeTwos.firstWhere((m) =>
          m.defaultConfigurations.sessionId ==
          modeTwo.defaultConfigurations.sessionId);
      existingModeTwo.results.addAll(modeTwo.results);
    } catch (error) {
      modeInfo.modeTwos.add(modeTwo);
    }

    await modeInfo.save();
  }
}
