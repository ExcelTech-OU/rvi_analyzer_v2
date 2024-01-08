import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class LoginInfo extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String jwt;

  LoginInfo(this.username, this.jwt);
}
