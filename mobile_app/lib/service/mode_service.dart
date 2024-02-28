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
import 'package:rvi_analyzer/repository/entity/mode_seven_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';
import 'package:rvi_analyzer/repository/modes_info_repo.dart';

Future<CommonResponse> saveModeOne(ModeOne modeOne, String username,
    {bool needToSaveLocal = true}) async {
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
      if (needToSaveLocal) {
        await repo.saveOrUpdateModeOne(username, modeOne);
      }
      return CommonResponse.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    if (needToSaveLocal) {
      await repo.saveOrUpdateModeOne(username, modeOne);
    }

    return CommonResponse.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeSeven(ModeSeven modeSeven, String username,
    {bool needToSaveLocal = true}) async {
  const storage = FlutterSecureStorage();

  try {
    String? jwt = await storage.read(key: jwtK);
    final response = await http.post(
      Uri.parse('$baseUrl$saveModeSevenPath'),
      headers: <String, String>{
        contentTypeK: contentTypeJsonK,
        authorizationK: '$bearerK $jwt',
      },
      body: jsonEncode(modeSeven),
    );

    print(response.body);
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

Future<ModeOneResp> getLastModeOne(String username) async {
  const storage = FlutterSecureStorage();
  final repo = ModeInfoRepository();

  ModeOneResp resp = ModeOneResp.fromDetails("", "");

  try {
    var value = await repo.getLastModeOne(
        username); // Wait for the repo.getLastModeOne to complete
    if (value != null) {
      resp.sessions = [value];
    } else {
      String? jwt = await storage.read(key: jwtK);
      final response = await http.get(
        Uri.parse('$baseUrl$getLastModeOnePath'),
        headers: <String, String>{
          contentTypeK: contentTypeJsonK,
          authorizationK: '$bearerK $jwt',
        },
      );
      if (response.statusCode == 200) {
        resp = ModeOneResp.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        resp = ModeOneResp.fromDetails("E2000", "Session Expired");
      } else {
        resp = ModeOneResp.fromDetails(
            "E1000", "Cannot update the data. Please try again");
      }
    }

    return resp; // Return the response after the block is completed
  } catch (e) {
    return ModeOneResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeTwo(ModeTwo modeTwo, String username,
    {bool needToSaveLocal = true}) async {
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
    print(response.body);
    if (response.statusCode == 200) {
      return CommonResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return CommonResponse.fromDetails("E2000", "Session Expired");
    } else {
      if (needToSaveLocal) {
        await repo.saveOrUpdateModeTwo(username, modeTwo);
      }

      return CommonResponse.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    if (needToSaveLocal) {
      await repo.saveOrUpdateModeTwo(username, modeTwo);
    }

    return CommonResponse.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<ModeTwoResp> getLastModeTwo(String username) async {
  const storage = FlutterSecureStorage();

  final repo = ModeInfoRepository();

  ModeTwoResp resp = ModeTwoResp.fromDetails("", "");

  try {
    var value = await repo.getLastModeTwo(username);

    if (value != null) {
      resp.sessions = [value];
    } else {
      String? jwt = await storage.read(key: jwtK);
      final response = await http.get(
        Uri.parse('$baseUrl$getLastModeTwoPath'),
        headers: <String, String>{
          contentTypeK: contentTypeJsonK,
          authorizationK: '$bearerK $jwt',
        },
      );
      if (response.statusCode == 200) {
        resp = ModeTwoResp.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        resp = ModeTwoResp.fromDetails("E2000", "Session Expired");
      } else {
        resp = ModeTwoResp.fromDetails(
            "E1000", "Cannot update the data. Please try again");
      }
    }

    return resp;
  } catch (e) {
    return ModeTwoResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeThree(ModeThree modeThree, String username,
    {bool needToSaveLocal = true}) async {
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
      if (needToSaveLocal) {
        await repo.saveOrUpdateModeThree(username, modeThree);
      }
      await repo.saveOrUpdateModeThree(username, modeThree);
      return CommonResponse.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    if (needToSaveLocal) {
      await repo.saveOrUpdateModeThree(username, modeThree);
    }
    return CommonResponse.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<ModeThreeResp> getLastModeThree(String username) async {
  const storage = FlutterSecureStorage();
  final repo = ModeInfoRepository();

  ModeThreeResp resp = ModeThreeResp.fromDetails("", "");

  try {
    var value = await repo.getLastModeThree(username);

    if (value != null) {
      resp.sessions = [value];
    } else {
      String? jwt = await storage.read(key: jwtK);
      final response = await http.get(
        Uri.parse('$baseUrl$getLastModeThreePath'),
        headers: <String, String>{
          contentTypeK: contentTypeJsonK,
          authorizationK: '$bearerK $jwt',
        },
      );
      if (response.statusCode == 200) {
        resp = ModeThreeResp.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        resp = ModeThreeResp.fromDetails("E2000", "Session Expired");
      } else {
        resp = ModeThreeResp.fromDetails(
            "E1000", "Cannot update the data. Please try again");
      }
    }

    return resp;
  } catch (e) {
    return ModeThreeResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeFour(ModeFour modeFour, String username,
    {bool needToSaveLocal = true}) async {
  const storage = FlutterSecureStorage();
  final repo = ModeInfoRepository();

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
      if (needToSaveLocal) {
        await repo.saveOrUpdateModeFour(username, modeFour);
      }
      return CommonResponse.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    if (needToSaveLocal) {
      await repo.saveOrUpdateModeFour(username, modeFour);
    }
    return CommonResponse.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<ModeFourResp> getLastModeFour(String username) async {
  const storage = FlutterSecureStorage();
  final repo = ModeInfoRepository();

  ModeFourResp resp = ModeFourResp.fromDetails("", "");

  try {
    var value = await repo.getLastModeFour(username);

    if (value != null) {
      resp.sessions = [value];
    } else {
      String? jwt = await storage.read(key: jwtK);
      final response = await http.get(
        Uri.parse('$baseUrl$getLastModeFourPath'),
        headers: <String, String>{
          contentTypeK: contentTypeJsonK,
          authorizationK: '$bearerK $jwt',
        },
      );
      if (response.statusCode == 200) {
        resp = ModeFourResp.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        resp = ModeFourResp.fromDetails("E2000", "Session Expired");
      } else {
        resp = ModeFourResp.fromDetails(
            "E1000", "Cannot update the data. Please try again");
      }
    }
    return resp;
  } catch (e) {
    return ModeFourResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeFive(ModeFive modeFive, String username,
    {bool needToSaveLocal = true}) async {
  final repo = ModeInfoRepository();

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
      if (needToSaveLocal) {
        await repo.saveOrUpdateModeFive(username, modeFive);
      }
      return CommonResponse.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    if (needToSaveLocal) {
      await repo.saveOrUpdateModeFive(username, modeFive);
    }
    return CommonResponse.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<ModeFiveResp> getLastModeFive(String username) async {
  const storage = FlutterSecureStorage();

  final repo = ModeInfoRepository();

  ModeFiveResp resp = ModeFiveResp.fromDetails("", "");

  try {
    var value = await repo.getLastModeFive(username);

    if (value != null) {
      resp.sessions = [value];
    } else {
      String? jwt = await storage.read(key: jwtK);
      final response = await http.get(
        Uri.parse('$baseUrl$getLastModeFivePath'),
        headers: <String, String>{
          contentTypeK: contentTypeJsonK,
          authorizationK: '$bearerK $jwt',
        },
      );
      if (response.statusCode == 200) {
        resp = ModeFiveResp.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        resp = ModeFiveResp.fromDetails("E2000", "Session Expired");
      } else {
        resp = ModeFiveResp.fromDetails(
            "E1000", "Cannot update the data. Please try again");
      }
    }
    return resp;
  } catch (e) {
    return ModeFiveResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<CommonResponse> saveModeSix(ModeSix modeSix, String username,
    {bool needToSaveLocal = true}) async {
  final repo = ModeInfoRepository();

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
      if (needToSaveLocal) {
        await repo.saveOrUpdateModeSix(username, modeSix);
      }

      return CommonResponse.fromDetails(
          "E1000", "Cannot update the data. Please try again");
    }
  } catch (e) {
    if (needToSaveLocal) {
      await repo.saveOrUpdateModeSix(username, modeSix);
    }

    return CommonResponse.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}

Future<ModeSixResp> getLastModeSix(String username) async {
  const storage = FlutterSecureStorage();

  final repo = ModeInfoRepository();

  ModeSixResp resp = ModeSixResp.fromDetails("", "");

  try {
    var value = await repo.getLastModeSIX(username);

    if (value != null) {
      resp.sessions = [value];
    } else {
      String? jwt = await storage.read(key: jwtK);
      final response = await http.get(
        Uri.parse('$baseUrl$getLastModeSixPath'),
        headers: <String, String>{
          contentTypeK: contentTypeJsonK,
          authorizationK: '$bearerK $jwt',
        },
      );
      if (response.statusCode == 200) {
        resp = ModeSixResp.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        resp = ModeSixResp.fromDetails("E2000", "Session Expired");
      } else {
        resp = ModeSixResp.fromDetails(
            "E1000", "Cannot update the data. Please try again");
      }
    }
    return resp;
  } catch (e) {
    return ModeSixResp.fromDetails(
        "E1000", "Cannot update the data. Please try again");
  }
}
