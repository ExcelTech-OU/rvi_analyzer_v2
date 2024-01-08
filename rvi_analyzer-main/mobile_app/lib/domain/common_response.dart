import 'package:rvi_analyzer/common/key_box.dart';

class CommonResponse {
  final String status;
  final String statusDescription;

  const CommonResponse({required this.status, required this.statusDescription});

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
        status: json[statusK], statusDescription: json[statusDescriptionK]);
  }

  factory CommonResponse.fromDetails(String state, String stateDescription) {
    return CommonResponse(status: state, statusDescription: stateDescription);
  }
}
