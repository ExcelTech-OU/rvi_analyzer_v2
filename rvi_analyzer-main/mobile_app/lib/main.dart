import 'dart:async';

import 'package:flutter/services.dart';
import 'package:rvi_analyzer/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rvi_analyzer/domain/common_response.dart';
import 'package:http/http.dart' as htpp;
import 'package:rvi_analyzer/repository/adapter/common_adapter.dart';
import 'package:rvi_analyzer/repository/adapter/connected_devices_info_adapter.dart';
import 'package:rvi_analyzer/repository/adapter/login_info_adapter.dart';
import 'package:rvi_analyzer/repository/adapter/mode_five_adapter.dart';
import 'package:rvi_analyzer/repository/adapter/mode_four_adapter.dart';
import 'package:rvi_analyzer/repository/adapter/mode_info_adapter.dart';
import 'package:rvi_analyzer/repository/adapter/mode_one_adapter.dart';
import 'package:rvi_analyzer/repository/adapter/mode_six_adapter.dart';
import 'package:rvi_analyzer/repository/adapter/mode_three_adapter.dart';
import 'package:rvi_analyzer/repository/adapter/mode_two_adapter.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/login_info.dart';
import 'package:rvi_analyzer/repository/entity/mode_five_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_four_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_info.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';
import 'package:rvi_analyzer/repository/login_repo.dart';
import 'package:rvi_analyzer/repository/modes_info_repo.dart';
import 'package:rvi_analyzer/service/mode_service.dart';

import 'package:rvi_analyzer/views/auth/sign_in/sign_in.dart';
import 'package:rvi_analyzer/views/dashboard/dashboard.dart';
import 'package:rvi_analyzer/views/splash/splash_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  registerAdapters();
  runApp(const ProviderScope(child: AchillesUIApp()));
}

void registerAdapters() {
  Hive.registerAdapter<DefaultConfiguration>(DefaultConfigurationAdapter());
  Hive.registerAdapter<Reading>(ReadingAdapter());
  Hive.registerAdapter<SessionResult>(SessionResultAdapter());
  Hive.registerAdapter<SessionConfigurationModeOne>(
      SessionConfigurationModeOneAdapter());
  Hive.registerAdapter<ModeOne>(ModeOneAdapter());

  Hive.registerAdapter<SessionConfigurationModeTwo>(
      SessionConfigurationModeTwoAdapter());
  Hive.registerAdapter<ModeTwo>(ModeTwoAdapter());

  Hive.registerAdapter<SessionConfigurationModeThree>(
      SessionConfigurationModeThreeAdapter());
  Hive.registerAdapter<ModeThree>(ModeThreeAdapter());

  Hive.registerAdapter<SessionConfigurationModeFour>(
      SessionConfigurationModeFourAdapter());
  Hive.registerAdapter<ModeFour>(ModeFourAdapter());

  Hive.registerAdapter<SessionConfigurationModeFive>(
      SessionConfigurationModeFiveAdapter());
  Hive.registerAdapter<ModeFive>(ModeFiveAdapter());

  Hive.registerAdapter<SessionConfigurationModeSix>(
      SessionConfigurationModeSixAdapter());
  Hive.registerAdapter<ModeSix>(ModeSixAdapter());

  Hive.registerAdapter<ModeInfo>(ModeInfoAdapter());

  Hive.registerAdapter(LoginInfoAdapter());
  Hive.registerAdapter(ConnectedDevicesInfoAdapter());
}

class AchillesUIApp extends StatefulWidget {
  const AchillesUIApp({Key? key}) : super(key: key);

  @override
  State<AchillesUIApp> createState() => _AchillesUIAppState();
}

class _AchillesUIAppState extends State<AchillesUIApp> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool insideSubmit = false;

  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        print("MOBILE");
        submitLocalSessions();
        // I am connected to a mobile network.
      } else if (result == ConnectivityResult.wifi) {
        print("WIFI");
        submitLocalSessions();
        // I am connected to a wifi network.
      } else if (result == ConnectivityResult.ethernet) {
        // I am connected to a ethernet network.
      } else if (result == ConnectivityResult.vpn) {
        // I am connected to a vpn network.
        // Note for iOS and macOS:
        // There is no separate network interface type for [vpn].
        // It returns [other] on any device (also simulator)
      } else if (result == ConnectivityResult.none) {
        print("NONE");
      }
    });
  }

  Future<void> submitLocalSessions() async {
    ModeInfoRepository repo = ModeInfoRepository();
    final loginInfoRepo = LoginInfoRepository();

    List<LoginInfo> infos = await loginInfoRepo.getAllLoginInfos();

    if (infos.isNotEmpty) {
      String username = infos.first.username;

      ModeInfo? modeInfo = await repo.getModeInfoForUsername(username);

      if (modeInfo != null && !insideSubmit) {
        setState(() {
          insideSubmit = true;
        });
        List<ModeOne> modeOneList = List.from(modeInfo.modeOnes);
        for (var element in modeOneList) {
          try {
            CommonResponse resp =
                await saveModeOne(element, username, needToSaveLocal: false);
            if (resp.status == 'S1000') {
              // await repo.removeModeOne(username, element);
            } else {
              //not remove since it was failed to submit
            }
          } catch (e) {
            //not remove since it was failed to submit
          }
        }

        List<ModeTwo> modeTwoList = List.from(modeInfo.modeTwos);
        for (var element in modeTwoList) {
          try {
            CommonResponse resp =
                await saveModeTwo(element, username, needToSaveLocal: false);
            print(resp.status);

            if (resp.status == 'S1000') {
              await repo.removeModeTwo(username, element);
            } else {
              //not remove since it was failed to submit
            }
          } catch (e) {
            //not remove since it was failed to submit
          }
        }

        List<ModeThree> modeThreeList = List.from(modeInfo.modeThrees);
        for (var element in modeThreeList) {
          try {
            CommonResponse resp =
                await saveModeThree(element, username, needToSaveLocal: false);
            if (resp.status == 'S1000') {
              await repo.removeModeThree(username, element);
            } else {
              //not remove since it was failed to submit
            }
          } catch (e) {
            //not remove since it was failed to submit
          }
        }

        List<ModeFour> modeFourList = List.from(modeInfo.modeFours);
        for (var element in modeFourList) {
          try {
            CommonResponse resp =
                await saveModeFour(element, username, needToSaveLocal: false);
            if (resp.status == 'S1000') {
              await repo.removeModeFour(username, element);
            } else {
              //not remove since it was failed to submit
            }
          } catch (e) {
            //not remove since it was failed to submit
          }
        }

        List<ModeFive> modeFiveList = List.from(modeInfo.modeFives);
        for (var element in modeFiveList) {
          try {
            CommonResponse resp =
                await saveModeFive(element, username, needToSaveLocal: false);
            if (resp.status == 'S1000') {
              await repo.removeModeFive(username, element);
            } else {
              //not remove since it was failed to submit
            }
          } catch (e) {
            //not remove since it was failed to submit
          }
        }

        List<ModeSix> modeSixList = List.from(modeInfo.modeSixs);
        for (var element in modeSixList) {
          try {
            CommonResponse resp =
                await saveModeSix(element, username, needToSaveLocal: false);
            if (resp.status == 'S1000') {
              await repo.removeModeSix(username, element);
            } else {
              //not remove since it was failed to submit
            }
          } catch (e) {
            //not remove since it was failed to submit
          }
        }
        setState(() {
          insideSubmit = false;
        });
      }
    }
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'RVI Analyzer',
      theme: customDarkTheme(),
      routes: {
        '/': (BuildContext context) => SplashScreen(),
        '/login': (BuildContext context) => const SignIn(),
        '/home': (BuildContext context) => DashboardPage(
              initialIndex: 0,
            )
      },
    );
  }

  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
