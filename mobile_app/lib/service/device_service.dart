import 'dart:async';
import 'dart:convert';
import 'package:rvi_analyzer/common/config.dart';
import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/domain/device_status_validation_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<DeviceStatusValidationResponse> validateDeviceByName(
    String deviceName) async {
  const storage = FlutterSecureStorage();
  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.post(
      Uri.parse('$baseUrl$deviceValidationPath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
      body: jsonEncode(<String, String>{nameK: deviceName}),
    );

    if (response.statusCode == 200) {
      return DeviceStatusValidationResponse.fromJson(jsonDecode(response.body));
    } else {
      return DeviceStatusValidationResponse.fromDetails(
          "E1000", "Cannot validate device status. Please try again");
    }
  } catch (e) {
    return DeviceStatusValidationResponse.fromDetails(
        "E1000", "Cannot validate device status. Please try again");
  }
}
