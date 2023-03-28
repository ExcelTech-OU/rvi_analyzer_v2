import 'package:flutter/material.dart';

MaterialColor getStatusColor(int statusId) {
  switch (statusId) {
    case 1:
      return Colors.orange;
    case 2:
      return Colors.green;
    case 3:
      return Colors.yellow;
    case 4:
      return Colors.blue;
    case 5:
      return Colors.red;
    case 6:
      return Colors.orange;
    default:
      return Colors.green;
  }
}

String getStatusText(int statusId) {
  switch (statusId) {
    case 1:
      return "Powered on Not ready";
    case 2:
      return "Ready";
    case 3:
      return "Running";
    case 4:
      return "Calibrating";
    case 5:
      return "Error/ Not ready";
    case 6:
      return "Stopped / Completed";
    default:
      return "Other";
  }
}
