import 'package:rvi_analyzer/common/key_box.dart';
import 'heater.dart';

class HeaterByDeviceIdResponse {
  final String status;
  final Heater? heater;

  const HeaterByDeviceIdResponse({
    required this.status,
    required this.heater,
  });

  factory HeaterByDeviceIdResponse.fromJson(Map<String, dynamic> json) {
    return HeaterByDeviceIdResponse(
      status: json[statusK],
      heater: json[heaterK] == null ? null : Heater.fromJson(json[heaterK]),
    );
  }

  factory HeaterByDeviceIdResponse.fromDetails(String status, Heater? heater) {
    return HeaterByDeviceIdResponse(
      status: status,
      heater: heater,
    );
  }
}
