import 'dart:async';
import 'dart:convert';
import 'package:rvi_analyzer/common/config.dart';
import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/domain/device_status_validation_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rvi_analyzer/repository/connected_devices_info_repo.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';
import 'package:rvi_analyzer/repository/login_repo.dart';

Future<DeviceStatusValidationResponse> validateDeviceByMac(String mac) async {
  final ConnectedDevicesInfoRepository connectedRepo =
      ConnectedDevicesInfoRepository();

  final loginInfoRepo = LoginInfoRepository();
  const storage = FlutterSecureStorage();

  List<LoginInfo> infos = await loginInfoRepo.getAllLoginInfos();

  try {
    var value = await connectedRepo
        .getConnectedDevicesInfoByUserName(infos.first.username);

    if (value != null && value.devicesMacs.contains(mac)) {
      return DeviceStatusValidationResponse.fromDetails("S1000", "Success");
    } else {
      String? jwt = await storage.read(key: jwtK);
      final response = await http.post(
        Uri.parse('$baseUrl$deviceValidationPath'),
        headers: <String, String>{
          contentTypeK: contentTypeJsonK,
          authorizationK: '$bearerK $jwt',
        },
        body: jsonEncode(<String, String>{macK: mac}),
      );
      if (response.statusCode == 200) {
        return DeviceStatusValidationResponse.fromJson(
            jsonDecode(response.body));
      } else {
        return DeviceStatusValidationResponse.fromDetails(
            "E1000", "Cannot validate device status. Please try again");
      }
    }
  } catch (e) {
    return DeviceStatusValidationResponse.fromDetails(
        "E1000", "Cannot validate device status. Please try again");
  }
}
