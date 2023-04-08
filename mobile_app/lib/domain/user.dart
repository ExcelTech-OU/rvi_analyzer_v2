import 'package:rvi_analyzer/common/key_box.dart';

class User {
  final String userName;
  final String type;
  final String status;
  final String createdBy;
  final String createdDateTime;
  final String lastUpdatedDateTime;

  const User(
      {required this.userName,
      required this.type,
      required this.status,
      this.createdBy = "",
      this.createdDateTime = "",
      this.lastUpdatedDateTime = ""});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        status: json[statusK],
        type: json[typeK],
        userName: json[userNameK],
        createdBy: json[createdByK]);
  }
}
