import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rvi_analyzer/domain/common_response.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';
import 'package:rvi_analyzer/repository/login_repo.dart';

import '../common/config.dart';
import '../common/key_box.dart';
import '../domain/login_response.dart';
import '../domain/simple_user.dart';

Future<LoginResponse> login(
    String userName, String password, BuildContext context) async {
  final loginInfoRepo = LoginInfoRepository();
  const storage = FlutterSecureStorage();
  final response = await http.post(
    Uri.parse('$baseUrl$loginPath'),
    headers: <String, String>{
      contentTypeK: contentTypeJsonK,
    },
    body: jsonEncode(<String, String>{
      userNameK: userName,
      passwordK: password.trim(),
      sourceK: "MOBILE"
    }),
  );

  await Future.delayed(const Duration(seconds: 3));
  if (response.statusCode == 200) {
    LoginResponse loginResponse =
        LoginResponse.fromJson(jsonDecode(response.body));
    await storage.write(key: jwtK, value: loginResponse.jwt);
    await storage.write(key: userTypeK, value: loginResponse.user?.group);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loginResponse.user!.group),
        // duration: const Duration(seconds: 2), // Adjust duration as needed
      ),
    );
    loginInfoRepo.addLoginInfo(LoginInfo(userName, loginResponse.jwt));
    return loginResponse;
  } else if (response.statusCode == 401) {
    LoginResponse loginResponse =
        LoginResponse.fromJson(jsonDecode(response.body));
    if (loginResponse.state == "E1200") {
      return LoginResponse.fromDetails("E1200",
          "You are not authorized to use this service", "Hello error", null);
    }
    return LoginResponse.fromDetails("E1000", "Error", "Hello error", null);
  } else {
    return LoginResponse.fromDetails("E1000", "Error", "Hello error", null);
  }
}

Future<CommonResponse> resetPassword(String jwt, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl$resetPasswordPath'),
    headers: <String, String>{
      contentTypeK: contentTypeJsonK,
      authorizationK: '$bearerK $jwt',
    },
    body: jsonEncode(<String, String>{passwordK: password}),
  );
  await Future.delayed(const Duration(seconds: 2));
  if (response.statusCode == 200) {
    CommonResponse loginResponse =
        CommonResponse.fromJson(jsonDecode(response.body));
    return loginResponse;
  } else {
    return CommonResponse.fromDetails("E1000", "Error");
  }
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

Future<CommonResponse> checkJwt() async {
  const storage = FlutterSecureStorage();

  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.get(
      Uri.parse('$baseUrl$jwtCheckPath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
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
    return CommonResponse.fromDetails("E2500", "No Connection");
  }
}

Future<void> logout() async {
  const storage = FlutterSecureStorage();
  await storage.delete(key: jwtK);
  await storage.delete(key: userTypeK);
}

Future<bool> isLogout() async {
  const storage = FlutterSecureStorage();
  try {
    String? jwt = await storage.read(key: "jwt");
    return jwt == null;
  } catch (e) {
    return true;
  }
}
