import 'package:rvi_analyzer/common/key_box.dart';

class User {
  final String username;
  final String group;
  final String status;
  final String createdBy;
  final String createdDateTime;
  final String lastUpdatedDateTime;

  const User(
      {required this.username,
      required this.group,
      required this.status,
      this.createdBy = "",
      this.createdDateTime = "",
      this.lastUpdatedDateTime = ""});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        status: json[statusK],
        group: json[groupK],
        username: json[usernameK],
        createdBy: json[createdByK]);
  }
}
