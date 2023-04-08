import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rvi_analyzer/service/login_service.dart';
import 'package:rvi_analyzer/views/auth/sign_in/sign_in.dart';

import '../common/config.dart';
import '../common/key_box.dart';
import '../domain/validate_response.dart';

Future<ValidateResponse> validatePassword(String password) async {
  const storage = FlutterSecureStorage();
  String? jwt = await storage.read(key: jwtK);
  final response = await http.post(
    Uri.parse('$baseUrl$userPasswordValidatePath'),
    headers: <String, String>{
      contentTypeK: contentTypeJsonK,
      authorizationK: '$bearerK $jwt',
    },
    body: jsonEncode(<String, String>{
      passwordK: password,
    }),
  );

  if (response.statusCode == 200) {
    return ValidateResponse.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return ValidateResponse.fromDetails("E1004", "Invalided password");
  } else {
    return ValidateResponse.fromDetails("E1000", "Try again later");
  }
}

Future<ValidateResponse> validateUsername(String username) async {
  const storage = FlutterSecureStorage();
  String? jwt = await storage.read(key: jwtK);
  final response = await http.post(
    Uri.parse('$baseUrl$userUsernameValidatePath'),
    headers: <String, String>{
      contentTypeK: contentTypeJsonK,
      authorizationK: '$bearerK $jwt',
    },
    body: jsonEncode(<String, String>{
      usernameK: username,
    }),
  );

  if (response.statusCode == 200) {
    return ValidateResponse.fromJson(jsonDecode(response.body));
  } else {
    return ValidateResponse.fromDetails("E1000", "Try again later");
  }
}

void showErrorDialog(BuildContext context, String error) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    pageBuilder: (ctx, a1, a2) {
      return Container();
    },
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          elevation: 40,
          title: Center(
              child: Text(error,
                  style: const TextStyle(fontSize: 15, color: Colors.black))),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 350),
  );
}

void showLogoutPopup(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "",
    pageBuilder: (ctx, a1, a2) {
      return Container();
    },
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          elevation: 40,
          title: const Center(
              child: Text("Your Session Expired, Please Login again",
                  style: TextStyle(fontSize: 15, color: Colors.black))),
          actions: <Widget>[
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                logout().then((value) => {
                      Navigator.of(context).pop(),
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route route) => false)
                    });
              },
            ),
          ],
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 350),
  );
}
