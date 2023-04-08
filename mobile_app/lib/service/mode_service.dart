import 'dart:async';
import 'dart:convert';
import 'package:rvi_analyzer/common/config.dart';
import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/domain/common_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rvi_analyzer/domain/mode_one.dart';

Future<CommonResponse> saveModeOne(ModeOne modeOne) async {
  const storage = FlutterSecureStorage();
  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.post(
      Uri.parse('$baseUrl$saveModeOnePath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
      body: jsonEncode(modeOne),
    );
    if (response.statusCode == 200) {
      return CommonResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return CommonResponse.fromDetails("E2000", "Session Expired");
    } else {
      return CommonResponse.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    return CommonResponse.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}
