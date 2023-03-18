import 'package:flutter/material.dart';

MaterialColor getStatusColor(int statusId) {
  switch (statusId) {
    case 1:
      return Colors.red;
    case 2:
      return Colors.green;
    case 3:
      return Colors.orange;
    case 4:
      return Colors.blue;
    case 5:
      return Colors.red;
    case 6:
      return Colors.orange;
    case 7:
      return Colors.orange;
    case 8:
      return Colors.green;
    case 9:
      return Colors.red;
    default:
      return Colors.green;
  }
}

String getStatusText(int statusId) {
  switch (statusId) {
    case 1:
      return "Not calibrated";
    case 2:
      return "Ready";
    case 3:
      return "Running";
    case 4:
      return "Calibrating";
    case 5:
      return "Not ready";
    case 6:
      return "Paused";
    case 7:
      return "Stopped";
    case 8:
      return "Other";
    case 9:
      return "Manually Operating";
    default:
      return "Other";
  }
}
