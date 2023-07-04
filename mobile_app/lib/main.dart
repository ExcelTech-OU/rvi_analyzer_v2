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
  Hive.registerAdapter(ModeOneAdapter());
  Hive.registerAdapter(SessionConfigurationModeOneAdapter());
  Hive.registerAdapter(SessionResultAdapter());
  Hive.registerAdapter(ReadingAdapter());
  Hive.registerAdapter(ModeTwoAdapter());
  Hive.registerAdapter(SessionConfigurationModeTwoAdapter());
  Hive.registerAdapter(ModeThreeAdapter());
  Hive.registerAdapter(SessionConfigurationModeThreeAdapter());
  Hive.registerAdapter(ModeFourAdapter());
  Hive.registerAdapter(SessionConfigurationModeFourAdapter());
  Hive.registerAdapter(ModeFiveAdapter());
  Hive.registerAdapter(SessionConfigurationModeFiveAdapter());
  Hive.registerAdapter(ModeSixAdapter());
  Hive.registerAdapter(SessionConfigurationModeSixAdapter());
  Hive.registerAdapter(DefaultConfigurationAdapter());
  Hive.registerAdapter(ModeInfoAdapter());
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
