import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';

class LoginInfoRepository {
  static final LoginInfoRepository _instance = LoginInfoRepository._internal();

  factory LoginInfoRepository() {
    return _instance;
  }

  LoginInfoRepository._internal();

  static const String _boxName = 'login_info';

  Future<Box<LoginInfo>> _openBox() async {
    final box = await Hive.openBox<LoginInfo>(_boxName);
    return box;
  }

  Future<void> addLoginInfo(LoginInfo loginInfo) async {
    final box = await _openBox();
    await box.clear();
    await box.add(loginInfo);
  }

  Future<List<LoginInfo>> getAllLoginInfos() async {
    final box = await _openBox();
    final loginInfos = box.values.toList();
    return loginInfos;
  }

  Future<LoginInfo?> getLoginInfoByUserName(String username) async {
    final box = await _openBox();
    final loginData = box.values.toList();

    try {
      LoginInfo? loginInfo =
          loginData.firstWhere((p) => p.username == username);
      return loginInfo;
    } catch (error) {
      return null;
    }
  }

  Future<void> removeByName(String username) async {
    final box = await _openBox();
    final loginInfo = await getLoginInfoByUserName(username);
    if (loginInfo != null) {
      await box.delete(loginInfo.key);
    }
  }
}
