import 'package:flutter/material.dart';

MaterialColor getBatteryColor(int percentage) {
  if (percentage >= 75) {
    return Colors.green;
  } else if (50 < percentage && percentage < 75) {
    return Colors.lightGreen;
  } else if (40 < percentage && percentage < 50) {
    return Colors.amber;
  } else if (30 < percentage && percentage < 40) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

IconData getBatteryIcon(int percentage) {
  if (percentage >= 85) {
    return Icons.battery_full;
  } else if (65 < percentage && percentage < 85) {
    return Icons.battery_6_bar;
  } else if (50 < percentage && percentage < 65) {
    return Icons.battery_5_bar;
  } else if (40 < percentage && percentage < 50) {
    return Icons.battery_4_bar;
  } else if (30 < percentage && percentage < 40) {
    return Icons.battery_2_bar;
  } else {
    return Icons.battery_0_bar;
  }
}
