class TreatmentConfig {
  String treatmentPosition;
  String temp;
  String time;
  bool ledState;
  int painLevel;
  int protocolId;
  int temId;
  int batteryLevel;
  TreatmentConfig(
      {required this.treatmentPosition,
      required this.temp,
      required this.time,
      required this.ledState,
      required this.painLevel,
      required this.protocolId,
      required this.temId,
      required this.batteryLevel});
}
