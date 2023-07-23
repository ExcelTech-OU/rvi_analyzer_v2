import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';

class ModeTwoResp {
  final String status;
  final String statusDescription;
  List<ModeTwo> sessions;

  ModeTwoResp(
      {required this.status,
      required this.statusDescription,
      required this.sessions});

  factory ModeTwoResp.fromJson(Map<String, dynamic> json) {
    List<ModeTwo> ss =
        (json[sessionsK] as List).map((e) => ModeTwo.fromJson(e)).toList();

    return ModeTwoResp(
        status: json[statusK],
        statusDescription: json[statusDescriptionK],
        sessions: ss);
  }

  factory ModeTwoResp.fromDetails(String state, String stateDescription) {
    return ModeTwoResp(
        status: state, statusDescription: stateDescription, sessions: []);
  }
}
