class SessionResult {
  final String testId;
  final List<Reading> readings;

  SessionResult({required this.testId, required this.readings});

  Map toJson() => {'testId': testId, 'readings': readings};
}

class Reading {
  final String temperature;
  final String current;
  final String voltage;
  final String result;
  final String readAt;

  Reading(
      {required this.temperature,
      required this.current,
      required this.voltage,
      required this.result,
      required this.readAt});

  Map toJson() => {
        'temperature': temperature,
        'current': current,
        'voltage': voltage,
        'result': result,
        'readAt': readAt,
      };
}
