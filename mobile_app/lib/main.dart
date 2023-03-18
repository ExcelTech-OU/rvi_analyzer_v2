import 'package:rvi_analyzer/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rvi_analyzer/views/auth/sign_in/sign_in.dart';
import 'package:rvi_analyzer/views/dashboard/dashboard.dart';
import 'package:rvi_analyzer/views/splash/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const ProviderScope(child: AchillesUIApp()));
}

class AchillesUIApp extends StatelessWidget {
  const AchillesUIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'RVI Analyzer',
      theme: customDarkTheme(),
      routes: {
        '/': (BuildContext context) => const SplashScreen(),
        '/login': (BuildContext context) => const SignIn(),
        '/home': (BuildContext context) => DashboardPage(
              initialIndex: 0,
            )
      },
    );
  }
}
