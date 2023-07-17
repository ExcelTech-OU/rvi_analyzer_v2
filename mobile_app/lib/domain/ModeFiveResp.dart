import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/repository/entity/mode_five_entity.dart';

class ModeFiveResp {
  final String status;
  final String statusDescription;
  final List<ModeFive> sessions;

  ModeFiveResp(
      {required this.status,
      required this.statusDescription,
      required this.sessions});

  factory ModeFiveResp.fromJson(Map<String, dynamic> json) {
    List<ModeFive> ss =
        (json[sessionsK] as List).map((e) => ModeFive.fromJson(e)).toList();

    return ModeFiveResp(
        status: json[statusK],
        statusDescription: json[statusDescriptionK],
        sessions: ss);
  }

  factory ModeFiveResp.fromDetails(String state, String stateDescription) {
    return ModeFiveResp(
        status: state, statusDescription: stateDescription, sessions: []);
  }
}
