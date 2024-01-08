import 'package:rvi_analyzer/common/key_box.dart';

class RegisterResponse {
  final String state;
  final String stateDescription;

  const RegisterResponse({
    required this.state,
    required this.stateDescription,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      state: json[statusK],
      stateDescription: json[statusDescriptionK],
    );
  }

  factory RegisterResponse.fromDetails(String state, String stateDescription) {
    return RegisterResponse(state: state, stateDescription: stateDescription);
  }
}
