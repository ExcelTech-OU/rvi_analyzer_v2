import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/domain/user.dart';

class LoginResponse {
  final String state;
  final String stateDescription;
  final String jwt;
  final User? user;
  List<String> roles = [];

  LoginResponse(
      {required this.state,
      required this.stateDescription,
      required this.jwt,
      required this.roles,
      this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        state: json[stateK],
        stateDescription: json[stateDescriptionK],
        jwt: json[jwtK] ?? "",
        roles: json[rolesK] == null
            ? List.empty()
            : List<String>.from(json[rolesK]),
        user: json[userK] == null ? null : User.fromJson(json[userK]));
  }

  factory LoginResponse.fromDetails(
      String state, String stateDescription, String jwt, User? user) {
    return LoginResponse(
        state: state,
        stateDescription: stateDescription,
        jwt: jwt,
        roles: List.empty(),
        user: user);
  }
}
