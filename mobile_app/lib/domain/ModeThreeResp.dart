import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';

class ModeThreeResp {
  final String status;
  final String statusDescription;
  final List<ModeThree> sessions;

  ModeThreeResp(
      {required this.status,
      required this.statusDescription,
      required this.sessions});

  factory ModeThreeResp.fromJson(Map<String, dynamic> json) {
    List<ModeThree> ss =
        (json[sessionsK] as List).map((e) => ModeThree.fromJson(e)).toList();

    return ModeThreeResp(
        status: json[statusK],
        statusDescription: json[statusDescriptionK],
        sessions: ss);
  }

  factory ModeThreeResp.fromDetails(String state, String stateDescription) {
    return ModeThreeResp(
        status: state, statusDescription: stateDescription, sessions: []);
  }
}
