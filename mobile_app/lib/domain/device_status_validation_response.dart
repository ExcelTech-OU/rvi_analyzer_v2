import 'package:rvi_analyzer/common/key_box.dart';

class DeviceStatusValidationResponse {
  final String status;
  final String statusDescription;

  const DeviceStatusValidationResponse({
    required this.status,
    required this.statusDescription,
  });

  factory DeviceStatusValidationResponse.fromJson(Map<String, dynamic> json) {
    return DeviceStatusValidationResponse(
      status: json[statusK],
      statusDescription: json[statusDescriptionK],
    );
  }

  factory DeviceStatusValidationResponse.fromDetails(
      String status, String statusDescription) {
    return DeviceStatusValidationResponse(
      status: status,
      statusDescription: statusDescription,
    );
  }
}
