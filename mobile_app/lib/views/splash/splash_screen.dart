import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rvi_analyzer/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:rvi_analyzer/service/common_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        isLogout().then((isLogout) => isLogout
            ? {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false)
              }
            : {
                checkJwt().then((value) => {
                      if (value.status == "S1000")
                        {Navigator.pushReplacementNamed(context, "/home")}
                      else if (value.status == "E2500")
                        {showNoInternetPopup(context, ref)}
                      else
                        {showLogoutPopup(context, ref)}
                    })
              });
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: const Center(
          child: Text(
            'RVI Analyzer',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
