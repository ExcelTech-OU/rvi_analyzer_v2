import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class LoginInfo extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String jwt;

  @HiveField(2)
  String group;

  LoginInfo(this.username, this.jwt, this.group);
}
