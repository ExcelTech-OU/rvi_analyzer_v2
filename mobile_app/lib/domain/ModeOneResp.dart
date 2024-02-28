import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';

class ModeOneResp {
  final String status;
  final String statusDescription;
  List<ModeOne> sessions;

  ModeOneResp(
      {required this.status,
      required this.statusDescription,
      required this.sessions});

  factory ModeOneResp.fromJson(Map<String, dynamic> json) {
    List<ModeOne> ss =
        (json[sessionsK] as List).map((e) => ModeOne.fromJson(e)).toList();

    return ModeOneResp(
        status: json[statusK],
        statusDescription: json[statusDescriptionK],
        sessions: ss);
  }

  factory ModeOneResp.fromDetails(String state, String stateDescription) {
    return ModeOneResp(
        status: state, statusDescription: stateDescription, sessions: []);
  }
}
