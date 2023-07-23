import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/mode_five_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_four_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_info.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';

class ModeInfoRepository {
  static final ModeInfoRepository _instance = ModeInfoRepository._internal();

  factory ModeInfoRepository() {
    return _instance;
  }

  ModeInfoRepository._internal();

  static const String _boxName = 'mode_info';

  Future<Box<ModeInfo>> _openBox() async {
    final box = await Hive.openBox<ModeInfo>(_boxName);
    return box;
  }

  Future<void> saveOrUpdateModeOne(String username, ModeOne modeOne) async {
    final box = await _openBox();

    ModeInfo? modeInfo = box.get(username);

    if (modeInfo != null) {
      try {
        final existingModeOne = modeInfo.modeOnes.firstWhere((m) =>
            m.defaultConfigurations.sessionId ==
            modeOne.defaultConfigurations.sessionId);
        existingModeOne.results.addAll(modeOne.results);
      } catch (error) {
        modeInfo.modeOnes.add(modeOne);
      }
    } else {
      modeInfo = ModeInfo(username, [], [], [], [], [], []);
      modeInfo.modeOnes.add(modeOne);
    }

    await box.put(username, modeInfo);
  }

  Future<ModeOne?> getLastModeOne(String username) async {
    final box = await _openBox();
    try {
      final modeInfo = box.get(username);
      if (modeInfo == null || modeInfo.modeOnes.isEmpty) {
        return null;
      } else {
        return modeInfo.modeOnes.last;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> removeModeOne(String username, String sessionId) async {
    final box = await _openBox();

    final modeInfo = box.values.firstWhere((info) => info.username == username,
        orElse: () => ModeInfo(username, [], [], [], [], [], []));
    try {
      final existingModeOne = modeInfo.modeOnes
          .firstWhere((m) => m.defaultConfigurations.sessionId == sessionId);
      modeInfo.modeOnes.remove(existingModeOne);
    } catch (error) {
      // print("cannot find the Mode one");
    }
    await box.add(modeInfo);
  }

  Future<void> saveOrUpdateModeTwo(String username, ModeTwo modeTwo) async {
    final box = await _openBox();

    ModeInfo? modeInfo = box.get(username);

    if (modeInfo != null) {
      try {
        final existingModeTwo = modeInfo.modeTwos.firstWhere((m) =>
            m.defaultConfigurations.sessionId ==
            modeTwo.defaultConfigurations.sessionId);
        existingModeTwo.results.addAll(modeTwo.results);
      } catch (error) {
        modeInfo.modeTwos.add(modeTwo);
      }
    } else {
      modeInfo = ModeInfo(username, [], [], [], [], [], []);
      modeInfo.modeTwos.add(modeTwo);
    }

    await box.put(username, modeInfo);
  }

  Future<ModeTwo?> getLastModeTwo(String username) async {
    final box = await _openBox();

    final modeInfo = box.get(username);
    if (modeInfo == null || modeInfo.modeTwos.isEmpty) {
      return null;
    } else {
      return modeInfo.modeTwos.last;
    }
  }

  Future<void> removeModeTwo(String username, String sessionId) async {
    final box = await _openBox();

    final modeInfo = box.values.firstWhere((info) => info.username == username,
        orElse: () => ModeInfo(username, [], [], [], [], [], []));
    try {
      final existingModeTwo = modeInfo.modeTwos
          .firstWhere((m) => m.defaultConfigurations.sessionId == sessionId);
      modeInfo.modeTwos.remove(existingModeTwo);
    } catch (error) {
      // print("cannot find the Mode one");
    }
    await box.add(modeInfo);
  }

  Future<void> saveOrUpdateModeThree(
      String username, ModeThree modeThree) async {
    final box = await _openBox();

    ModeInfo? modeInfo = box.get(username);

    if (modeInfo != null) {
      modeInfo.modeThrees.add(modeThree);
    } else {
      modeInfo = ModeInfo(username, [], [], [], [], [], []);
      modeInfo.modeThrees.add(modeThree);
    }
    await box.put(username, modeInfo);
  }

  Future<ModeThree?> getLastModeThree(String username) async {
    final box = await _openBox();

    final modeInfo = box.get(username);
    if (modeInfo == null || modeInfo.modeThrees.isEmpty) {
      return null;
    } else {
      return modeInfo.modeThrees.last;
    }
  }

  Future<void> removeModeThree(String username, String sessionId) async {
    final box = await _openBox();

    final modeInfo = box.values.firstWhere((info) => info.username == username,
        orElse: () => ModeInfo(username, [], [], [], [], [], []));
    try {
      final existingModeOne = modeInfo.modeThrees
          .firstWhere((m) => m.defaultConfigurations.sessionId == sessionId);
      modeInfo.modeThrees.remove(existingModeOne);
    } catch (error) {
      // print("cannot find the Mode one");
    }
    await box.add(modeInfo);
  }

  Future<void> saveOrUpdateModeFour(String username, ModeFour modeFour) async {
    final box = await _openBox();

    ModeInfo? modeInfo = box.get(username);

    if (modeInfo != null) {
      modeInfo.modeFours.add(modeFour);
    } else {
      modeInfo = ModeInfo(username, [], [], [], [], [], []);
      modeInfo.modeFours.add(modeFour);
    }
    await box.put(username, modeInfo);
  }

  Future<ModeFour?> getLastModeFour(String username) async {
    final box = await _openBox();

    final modeInfo = box.get(username);
    if (modeInfo == null || modeInfo.modeFours.isEmpty) {
      return null;
    } else {
      return modeInfo.modeFours.last;
    }
  }

  Future<void> removeModeFour(String username, String sessionId) async {
    final box = await _openBox();

    final modeInfo = box.values.firstWhere((info) => info.username == username,
        orElse: () => ModeInfo(username, [], [], [], [], [], []));
    try {
      final existingModeOne = modeInfo.modeFours
          .firstWhere((m) => m.defaultConfigurations.sessionId == sessionId);
      modeInfo.modeFours.remove(existingModeOne);
    } catch (error) {
      // print("cannot find the Mode one");
    }
    await box.add(modeInfo);
  }

  Future<void> saveOrUpdateModeFive(String username, ModeFive modeFive) async {
    final box = await _openBox();

    ModeInfo? modeInfo = box.get(username);

    if (modeInfo != null) {
      modeInfo.modeFives.add(modeFive);
    } else {
      modeInfo = ModeInfo(username, [], [], [], [], [], []);
      modeInfo.modeFives.add(modeFive);
    }
    await box.put(username, modeInfo);
  }

  Future<ModeFive?> getLastModeFive(String username) async {
    final box = await _openBox();

    final modeInfo = box.get(username);
    if (modeInfo == null || modeInfo.modeFives.isEmpty) {
      return null;
    } else {
      return modeInfo.modeFives.last;
    }
  }

  Future<void> removeModeFive(String username, String sessionId) async {
    final box = await _openBox();

    final modeInfo = box.values.firstWhere((info) => info.username == username,
        orElse: () => ModeInfo(username, [], [], [], [], [], []));
    try {
      final existingModeOne = modeInfo.modeFives
          .firstWhere((m) => m.defaultConfigurations.sessionId == sessionId);
      modeInfo.modeFives.remove(existingModeOne);
    } catch (error) {
      // print("cannot find the Mode one");
    }
    await box.add(modeInfo);
  }

  Future<void> saveOrUpdateModeSix(String username, ModeSix modeSix) async {
    final box = await _openBox();

    ModeInfo? modeInfo = box.get(username);

    if (modeInfo != null) {
      modeInfo.modeSixs.add(modeSix);
    } else {
      modeInfo = ModeInfo(username, [], [], [], [], [], []);
      modeInfo.modeSixs.add(modeSix);
    }
    await box.put(username, modeInfo);
  }

  Future<ModeSix?> getLastModeSIX(String username) async {
    final box = await _openBox();

    final modeInfo = box.get(username);
    if (modeInfo == null || modeInfo.modeSixs.isEmpty) {
      return null;
    } else {
      return modeInfo.modeSixs.last;
    }
  }

  Future<void> removeModeSix(String username, String sessionId) async {
    final box = await _openBox();

    final modeInfo = box.values.firstWhere((info) => info.username == username,
        orElse: () => ModeInfo(username, [], [], [], [], [], []));
    try {
      final existingModeOne = modeInfo.modeSixs
          .firstWhere((m) => m.defaultConfigurations.sessionId == sessionId);
      modeInfo.modeSixs.remove(existingModeOne);
    } catch (error) {
      // print("cannot find the Mode one");
    }
    await box.add(modeInfo);
  }
}
