import 'package:rvi_analyzer/common/key_box.dart';

class UserHistoryDashboardResponse {
  final String temperature;
  final String painLevel;
  final String name;
  final String totalTime;

  const UserHistoryDashboardResponse(
      {required this.temperature,
      required this.painLevel,
      required this.name,
      required this.totalTime});

  factory UserHistoryDashboardResponse.fromJson(Map<String, dynamic> json) {
    return UserHistoryDashboardResponse(
      temperature: json[temperatureK],
      painLevel: json[painLevelK],
      name: json[nameK],
      totalTime: json[totalTimeK],
    );
  }

  factory UserHistoryDashboardResponse.fromDetails(
      String temperature, String painLevel, String name, String totalTime) {
    return UserHistoryDashboardResponse(
        temperature: temperature,
        painLevel: painLevel,
        name: name,
        totalTime: totalTime);
  }
}
