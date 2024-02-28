import 'package:rvi_analyzer/common/key_box.dart';

class ValidateResponse {
  final String status;
  final String stateDescription;

  const ValidateResponse({
    required this.status,
    required this.stateDescription,
  });

  factory ValidateResponse.fromJson(Map<String, dynamic> json) {
    return ValidateResponse(
      status: json[stateK],
      stateDescription: json[stateDescriptionK],
    );
  }

  factory ValidateResponse.fromDetails(String status, String stateDescription) {
    return ValidateResponse(
      status: status,
      stateDescription: stateDescription,
    );
  }
}
