import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rvi_analyzer/domain/common_response.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';
import 'package:rvi_analyzer/repository/login_repo.dart';
import 'package:rvi_analyzer/service/common_service.dart';

import '../common/key_box.dart';
import '../common/config.dart';
import '../domain/login_response.dart';
import '../domain/simple_user.dart';

Future<LoginResponse> login(
    String userName, String password, BuildContext context) async {
  String usernameTest = "topAdmin2@gmail.com";
  String passwordTest = "12345";
  BuildContext bContext = context;
  String jwttoken =
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0b3BBZG1pbjJAZ21haWwuY29tIiwicm9sZXMiOiJbVE9QX0FETUlOXSIsImlhdCI6MTcwNDI1MDQ1MywiZXhwIjoxNzA0MjU2NDUzfQ.AkbuThdYMzCEyCqevJwNiU50MM7JUJ2NUwLpt0IBG3c";
  String accesstoken() => jwttoken;
  const bool useJwtToken = true;
  final loginInfoRepo = LoginInfoRepository();
  const storage = FlutterSecureStorage();
  // final response = await http.post(
  //   Uri.parse('$baseUrl$loginPath'),
  //   headers: <String, String>{
  //     contentTypeK: contentTypeJsonK,
  //   },
  //   body: jsonEncode(<String, String>{
  //     userNameK: userName,
  //     passwordK: password.trim(),
  //     sourceK: "MOBILE"
  //   }),
  // );

  await Future.delayed(const Duration(seconds: 3));
  // if (response.statusCode == 200) {
  //   LoginResponse loginResponse =
  //       LoginResponse.fromJson(jsonDecode(response.body));
  //   await storage.write(key: jwtK, value: loginResponse.jwt);
  //   loginInfoRepo.addLoginInfo(LoginInfo(userName, loginResponse.jwt));
  //   return loginResponse;
  // } else if (response.statusCode == 401) {
  //   LoginResponse loginResponse =
  //       LoginResponse.fromJson(jsonDecode(response.body));
  //   if (loginResponse.state == "E1200") {
  //     return LoginResponse.fromDetails("E1200",
  //         "You are not authorized to use this service", "Hello error", null);
  //   }
  //   return LoginResponse.fromDetails("E1000", "Error", "Hello error", null);
  // } else {
  //   return LoginResponse.fromDetails("E1000", "Error", "Hello error", null);
  // }

  if (usernameTest == userName && passwordTest == password) {
    Map<String, dynamic> userData = {
      "user": {
        "username": "topAdmin2@gmail.com",
        "group": "USER",
      }
    };
    if (kDebugMode) {
      print("works");
    }

    LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(jsonEncode({
      "user": {
        "username": "topAdmin2@gmail.com",
        "group": "USER",
        "status": "ACTIVE",
        "passwordType": "PASSWORD",
        "createdBy": "SUPER_USER",
        "createdDateTime": "2024-01-02T16:19:52.035",
        "lastUpdatedDateTime": "2024-01-02T16:19:52.036"
      },
      "state": "S1000",
      "stateDescription": "Success",
      "jwt":
          "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0b3BBZG1pbjJAZ21haWwuY29tIiwicm9sZXMiOiJbVE9QX0FETUlOXSIsImlhdCI6MTcwNDI1MDQ1MywiZXhwIjoxNzA0MjU2NDUzfQ.AkbuThdYMzCEyCqevJwNiU50MM7JUJ2NUwLpt0IBG3c",
      "roles": [
        "LOGIN_WEB",
        "CREATE_TOP_ADMIN",
        "CREATE_ADMIN",
        "RESET_PASSWORD",
        "UPDATE_DEVICE",
        "UPDATE_ADMIN_USER",
        "GET_ALL_USERS",
        "GET_DEVICES"
      ]
    })));
    String userGroup = userData['user']['group'];
    await storage.write(key: jwtK, value: loginResponse.jwt);
    loginInfoRepo.addLoginInfo(LoginInfo(userName, loginResponse.jwt));
    return loginResponse;
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
