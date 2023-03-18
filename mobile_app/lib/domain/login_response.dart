import 'package:rvi_analyzer/common/key_box.dart';

class LoginResponse {
  final String state;
  final String stateDescription;
  final String jwt;

  const LoginResponse(
      {required this.state, required this.stateDescription, required this.jwt});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      state: json[stateK],
      stateDescription: json[stateDescriptionK],
      jwt: json[jwtK],
    );
  }

  factory LoginResponse.fromDetails(
      String state, String stateDescription, String jwt) {
    return LoginResponse(
      state: state,
      stateDescription: stateDescription,
      jwt: jwt,
    );
  }
}
