import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../common/key_box.dart';
import '../common/config.dart';
import '../domain/login_response.dart';
import '../domain/simple_user.dart';

Future<LoginResponse> login(String userName, String password) async {
  const storage = FlutterSecureStorage();
  // final response = await http.post(
  //   Uri.parse('$baseUrl$loginPath'),
  //   headers: <String, String>{
  //     contentTypeK: contentTypeJsonK,
  //   },
  //   body: jsonEncode(<String, String>{
  //     usernameK: userName,
  //     passwordK: password,
  //   }),
  // );
  await Future.delayed(const Duration(seconds: 3));
  // if (response.statusCode == 200) {
  // LoginResponse loginResponse =
  //     LoginResponse.fromJson(jsonDecode(response.body));
  await storage.write(key: jwtK, value: "loginResponse.jwt");
  // return loginResponse;
  return LoginResponse.fromDetails("S1000", "Error", "Hello error");
  // } else {
  //   return LoginResponse.fromDetails("E1000", "Error", "Hello error");
  // }
}

Future<SimpleUser> userDetails() async {
  const storage = FlutterSecureStorage();
  String? jwt = await storage.read(key: jwtK);
  final response = await http.get(
    Uri.parse('$baseUrl$userDetailsPath'),
    headers: <String, String>{
      contentTypeK: contentTypeJsonK,
      authorizationK: '$bearerK $jwt',
    },
  );
  if (response.statusCode == 200) {
    return SimpleUser.fromJson(jsonDecode(response.body));
  } else {
    return SimpleUser.fromDetails("E1000", "Error", "Login Failed", "");
  }
}

Future<void> logout() async {
  const storage = FlutterSecureStorage();
  await storage.delete(key: jwtK);
}

Future<bool> loginCheck() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: "jwt");
  return value == null;
}
