import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';

class DefaultConfigurationAdapter extends TypeAdapter<DefaultConfiguration> {
  @override
  final typeId = 4;

  @override
  DefaultConfiguration read(BinaryReader reader) {
    return DefaultConfiguration(
      customerName: reader.readString(),
      operatorId: reader.readString(),
      batchNo: reader.readString(),
      serialNo: reader.readString(),
      sessionId: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, DefaultConfiguration obj) {
    writer.writeString(obj.customerName);
    writer.writeString(obj.operatorId);
    writer.writeString(obj.batchNo);
    writer.writeString(obj.serialNo);
    writer.writeString(obj.sessionId);
  }
}

class SessionResultAdapter extends TypeAdapter<SessionResult> {
  @override
  final int typeId = 5;

  @override
  SessionResult read(BinaryReader reader) {
    return SessionResult(
      testId: reader.readString(),
      readings: reader.readList().cast<Reading>(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionResult obj) {
    writer.writeString(obj.testId);
    writer.writeList(obj.readings);
  }
}

class ReadingAdapter extends TypeAdapter<Reading> {
  @override
  final int typeId = 6;

  @override
  Reading read(BinaryReader reader) {
    return Reading(
      temperature: reader.readString(),
      current: reader.readString(),
      voltage: reader.readString(),
      result: reader.readString(),
      readAt: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Reading obj) {
    writer.writeString(obj.temperature);
    writer.writeString(obj.current);
    writer.writeString(obj.voltage);
    writer.writeString(obj.result == null ? "" : obj.result!);
    writer.writeString(obj.readAt == null ? "" : obj.readAt!);
  }
}
