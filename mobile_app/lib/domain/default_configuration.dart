class DefaultConfiguration {
  final String customerName;
  final String operatorId;
  final String batchNo;
  final String serialNo;
  final String sessionId;

  DefaultConfiguration(
      {required this.customerName,
      required this.operatorId,
      required this.batchNo,
      required this.serialNo,
      required this.sessionId});

  Map toJson() => {
        'customerName': customerName,
        'operatorId': operatorId,
        'batchNo': batchNo,
        'serialNo': serialNo,
        'sessionId': sessionId,
      };
}
