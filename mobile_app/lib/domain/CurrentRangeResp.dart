import 'package:rvi_analyzer/common/key_box.dart';

class CurrentRangeResp {
  final String status;
  final String statusDescription;
  final String? lowerBound;
  final String? upperBound;

  CurrentRangeResp(
      {required this.status,
      required this.statusDescription,
      required this.lowerBound,
      required this.upperBound});

  factory CurrentRangeResp.fromJson(Map<String, dynamic> json) {
    return CurrentRangeResp(
        status: json[statusK],
        statusDescription: json[statusDescriptionK],
        lowerBound: json["lowerBound"],
        upperBound: json["upperBound"]);
  }

  factory CurrentRangeResp.fromDetails(String state, String stateDescription,
      {String? lowerBound, String? upperBound}) {
    return CurrentRangeResp(
        status: state,
        statusDescription: stateDescription,
        lowerBound: lowerBound,
        upperBound: upperBound);
  }
}
