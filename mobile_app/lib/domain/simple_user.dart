import 'package:rvi_analyzer/common/key_box.dart';

class SimpleUser {
  final String username;
  final String name;
  final String lastLogin;
  final String email;
  String age = "N/A";
  String gender = "Male";
  String occupation = "N/A";

  SimpleUser({
    required this.email,
    required this.username,
    required this.name,
    required this.lastLogin,
    this.age = "N/A",
    this.gender = "Male",
    this.occupation = "N/A",
  });

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      username: json[usernameK],
      name: json[nameK],
      lastLogin: json[lastLoginK],
      email: json[emailK],
      age: json[ageK],
      gender: json[genderK],
      occupation: json[occupationK],
    );
  }

  factory SimpleUser.fromDetails(
      String username, String name, String lastLogin, String email) {
    return SimpleUser(
        username: username, name: name, lastLogin: lastLogin, email: email);
  }
}
