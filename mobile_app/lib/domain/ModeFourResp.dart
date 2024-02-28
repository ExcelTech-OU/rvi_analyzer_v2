import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/repository/entity/mode_four_entity.dart';

class ModeFourResp {
  final String status;
  final String statusDescription;
  List<ModeFour> sessions;

  ModeFourResp(
      {required this.status,
      required this.statusDescription,
      required this.sessions});

  factory ModeFourResp.fromJson(Map<String, dynamic> json) {
    List<ModeFour> ss =
        (json[sessionsK] as List).map((e) => ModeFour.fromJson(e)).toList();

    return ModeFourResp(
        status: json[statusK],
        statusDescription: json[statusDescriptionK],
        sessions: ss);
  }

  factory ModeFourResp.fromDetails(String state, String stateDescription) {
    return ModeFourResp(
        status: state, statusDescription: stateDescription, sessions: []);
  }
}
