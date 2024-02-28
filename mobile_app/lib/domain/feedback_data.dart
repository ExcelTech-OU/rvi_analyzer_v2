import 'package:rvi_analyzer/domain/configure_data.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FeedbackData {
  TreatmentConfig? initialConfig;
  TreatmentConfig? afterConfig;
  ScanResult scanResult;
  List<Map<String, dynamic>> answers = [];
  int feedbackPainLevel;
  String status;
  FeedbackData(
      {required this.initialConfig,
      required this.afterConfig,
      required this.scanResult,
      required this.feedbackPainLevel,
      required this.status});
}
