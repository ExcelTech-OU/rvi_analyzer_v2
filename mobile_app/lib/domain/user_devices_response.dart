import 'package:rvi_analyzer/common/key_box.dart';

import 'device.dart';

class UserDevicesResponse {
  final String status;
  final List<Device> devices;

  const UserDevicesResponse({
    required this.status,
    required this.devices,
  });

  factory UserDevicesResponse.fromJson(Map<String, dynamic> json) {
    return UserDevicesResponse(
      status: json[statusK],
      devices: json[devicesK] == null
          ? []
          : List<Device>.from(json[devicesK].map((i) => Device.fromJson(i))),
    );
  }

  factory UserDevicesResponse.fromDetails(String status, List<Device> devices) {
    return UserDevicesResponse(
      status: status,
      devices: devices,
    );
  }
}
