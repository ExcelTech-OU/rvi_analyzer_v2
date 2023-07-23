import 'dart:async';
import 'dart:convert';
import 'package:rvi_analyzer/common/config.dart';
import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/domain/ModeFiveResp.dart';
import 'package:rvi_analyzer/domain/ModeFourResp.dart';
import 'package:rvi_analyzer/domain/ModeOneResp.dart';
import 'package:rvi_analyzer/domain/ModeSixResp.dart';
import 'package:rvi_analyzer/domain/ModeThreeResp.dart';
import 'package:rvi_analyzer/domain/ModeTwoResp.dart';
import 'package:rvi_analyzer/domain/common_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rvi_analyzer/repository/entity/mode_five_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_four_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';
import 'package:rvi_analyzer/repository/modes_info_repo.dart';

Future<CommonResponse> saveModeOne(ModeOne modeOne, String username) async {
  final repo = ModeInfoRepository();
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
      await repo.saveOrUpdateModeOne(username, modeOne);

      return CommonResponse.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    await repo.saveOrUpdateModeOne(username, modeOne);

    return CommonResponse.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<ModeOneResp> saveLastModeOne() async {
  const storage = FlutterSecureStorage();

  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.get(
      Uri.parse('$baseUrl$getLastModeOnePath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
    );
    if (response.statusCode == 200) {
      return ModeOneResp.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return ModeOneResp.fromDetails("E2000", "Session Expired");
    } else {
      return ModeOneResp.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    return ModeOneResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeTwo(ModeTwo modeTwo, String username) async {
  final repo = ModeInfoRepository();
  const storage = FlutterSecureStorage();
  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.post(
      Uri.parse('$baseUrl$saveModeTwoPath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
      body: jsonEncode(modeTwo),
    );
    if (response.statusCode == 200) {
      return CommonResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return CommonResponse.fromDetails("E2000", "Session Expired");
    } else {
      // await repo.saveOrUpdateModeTwo(username, modeTwo);

      return CommonResponse.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    // await repo.saveOrUpdateModeTwo(username, modeTwo);

    return CommonResponse.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<ModeTwoResp> getLastModeTwo() async {
  const storage = FlutterSecureStorage();

  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.get(
      Uri.parse('$baseUrl$getLastModeTwoPath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
    );
    if (response.statusCode == 200) {
      return ModeTwoResp.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return ModeTwoResp.fromDetails("E2000", "Session Expired");
    } else {
      return ModeTwoResp.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    return ModeTwoResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeThree(
    ModeThree modeThree, String username) async {
  final repo = ModeInfoRepository();
  const storage = FlutterSecureStorage();
  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.post(
      Uri.parse('$baseUrl$saveModeThreePath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
      body: jsonEncode(modeThree),
    );
    if (response.statusCode == 200) {
      return CommonResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return CommonResponse.fromDetails("E2000", "Session Expired");
    } else {
      // await repo.saveOrUpdateModeThree(username, modeThree);
      return CommonResponse.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    // await repo.saveOrUpdateModeThree(username, modeThree);
    return CommonResponse.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<ModeThreeResp> getLastModeThree() async {
  const storage = FlutterSecureStorage();

  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.get(
      Uri.parse('$baseUrl$getLastModeThreePath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
    );
    if (response.statusCode == 200) {
      return ModeThreeResp.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return ModeThreeResp.fromDetails("E2000", "Session Expired");
    } else {
      return ModeThreeResp.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    return ModeThreeResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeFour(ModeFour modeFour) async {
  const storage = FlutterSecureStorage();
  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.post(
      Uri.parse('$baseUrl$saveModeFourPath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
      body: jsonEncode(modeFour),
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

Future<ModeFourResp> getLastModeFour() async {
  const storage = FlutterSecureStorage();

  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.get(
      Uri.parse('$baseUrl$getLastModeFourPath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
    );
    if (response.statusCode == 200) {
      return ModeFourResp.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return ModeFourResp.fromDetails("E2000", "Session Expired");
    } else {
      return ModeFourResp.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    return ModeFourResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeFive(ModeFive modeFive) async {
  const storage = FlutterSecureStorage();
  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.post(
      Uri.parse('$baseUrl$saveModeFivePath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
      body: jsonEncode(modeFive),
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

Future<ModeFiveResp> getLastModeFive() async {
  const storage = FlutterSecureStorage();

  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.get(
      Uri.parse('$baseUrl$getLastModeFivePath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
    );
    if (response.statusCode == 200) {
      return ModeFiveResp.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return ModeFiveResp.fromDetails("E2000", "Session Expired");
    } else {
      return ModeFiveResp.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    return ModeFiveResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeSix(ModeSix modeSix) async {
  const storage = FlutterSecureStorage();
  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.post(
      Uri.parse('$baseUrl$saveModeSixPath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
      body: jsonEncode(modeSix),
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

Future<ModeSixResp> getLastModeSix() async {
  const storage = FlutterSecureStorage();

  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.get(
      Uri.parse('$baseUrl$getLastModeSixPath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
    );
    if (response.statusCode == 200) {
      return ModeSixResp.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return ModeSixResp.fromDetails("E2000", "Session Expired");
    } else {
      return ModeSixResp.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    return ModeSixResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}
