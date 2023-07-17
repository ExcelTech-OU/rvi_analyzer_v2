import 'package:flutter/services.dart';
import 'package:rvi_analyzer/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

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
import 'package:rvi_analyzer/repository/entity/mode_five_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_four_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_info.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';

import 'package:rvi_analyzer/views/auth/sign_in/sign_in.dart';
import 'package:rvi_analyzer/views/dashboard/dashboard.dart';
import 'package:rvi_analyzer/views/splash/splash_screen.dart';

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

class AchillesUIApp extends StatelessWidget {
  const AchillesUIApp({Key? key}) : super(key: key);

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
