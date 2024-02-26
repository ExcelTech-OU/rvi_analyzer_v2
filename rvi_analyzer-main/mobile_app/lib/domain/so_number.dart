class SOListResponse {
  final String status;
  final String statusDescription;
  final List<SO> soNumbers;

  SOListResponse(
      {required this.status,
      required this.statusDescription,
      required this.soNumbers});

  factory SOListResponse.fromJson(Map<String, dynamic> json) {
    final List<SO> soNumbers = [];
    for (final soData in json['soNumbers']) {
      soNumbers.add(SO.fromJson(soData));
    }

    return SOListResponse(
      status: json['status'],
      statusDescription: json['statusDescription'],
      soNumbers: soNumbers,
    );
  }
}

class SO {
  final String id;
  final String soNumber;
  final String customerPO;
  final String createdBy;
  final DateTime createdDateTime;

  SO(
      {required this.id,
      required this.soNumber,
      required this.customerPO,
      required this.createdBy,
      required this.createdDateTime});

  factory SO.fromJson(Map<String, dynamic> json) {
    return SO(
      id: json['_id'],
      soNumber: json['soNumber'],
      customerPO: json['customerPO'],
      createdBy: json['createdBy'],
      createdDateTime: DateTime.parse(json['createdDateTime']),
    );
  }
}
