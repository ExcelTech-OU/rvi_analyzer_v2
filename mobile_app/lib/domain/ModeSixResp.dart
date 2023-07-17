import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/repository/entity/mode_six_entity.dart';

class ModeSixResp {
  final String status;
  final String statusDescription;
  final List<ModeSix> sessions;

  ModeSixResp(
      {required this.status,
      required this.statusDescription,
      required this.sessions});

  factory ModeSixResp.fromJson(Map<String, dynamic> json) {
    List<ModeSix> ss =
        (json[sessionsK] as List).map((e) => ModeSix.fromJson(e)).toList();

    return ModeSixResp(
        status: json[statusK],
        statusDescription: json[statusDescriptionK],
        sessions: ss);
  }

  factory ModeSixResp.fromDetails(String state, String stateDescription) {
    return ModeSixResp(
        status: state, statusDescription: stateDescription, sessions: []);
  }
}
