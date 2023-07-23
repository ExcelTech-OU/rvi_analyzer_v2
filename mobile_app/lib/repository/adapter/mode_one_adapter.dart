import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';

class ModeOneAdapter extends TypeAdapter<ModeOne> {
  @override
  final typeId = 2;

  @override
  ModeOne read(BinaryReader reader) {
    final createdBy = reader.readString();
    final defaultConfigurations = DefaultConfiguration(
      customerName: reader.readString(),
      operatorId: reader.readString(),
      batchNo: reader.readString(),
      serialNo: reader.readString(),
      sessionId: reader.readString(),
    );
    final sessionConfigurationModeOne = SessionConfigurationModeOne(
      voltage: reader.readString(),
      maxCurrent: reader.readString(),
      passMinCurrent: reader.readString(),
      passMaxCurrent: reader.readString(),
    );

    final resultsLength = reader.readInt();
    final results =
        List<SessionResult>.generate(resultsLength, (_) => reader.read());
    final status = reader.readString();

    return ModeOne(
      createdBy: createdBy,
      defaultConfigurations: defaultConfigurations,
      sessionConfigurationModeOne: sessionConfigurationModeOne,
      results: results,
      status: status,
    );
  }

  @override
  void write(BinaryWriter writer, ModeOne obj) {
    writer.writeString(obj.createdBy);

    writer.writeString(obj.defaultConfigurations.customerName);
    writer.writeString(obj.defaultConfigurations.operatorId);
    writer.writeString(obj.defaultConfigurations.batchNo);
    writer.writeString(obj.defaultConfigurations.serialNo);
    writer.writeString(obj.defaultConfigurations.sessionId);

    writer.writeString(obj.sessionConfigurationModeOne.voltage);
    writer.writeString(obj.sessionConfigurationModeOne.maxCurrent);
    writer.writeString(obj.sessionConfigurationModeOne.passMinCurrent);
    writer.writeString(obj.sessionConfigurationModeOne.passMaxCurrent);

    writer.writeInt(obj.results.length);
    obj.results.forEach(writer.write);
    writer.writeString(obj.status);
  }
}

class SessionConfigurationModeOneAdapter
    extends TypeAdapter<SessionConfigurationModeOne> {
  @override
  final typeId = 3;

  @override
  SessionConfigurationModeOne read(BinaryReader reader) {
    return SessionConfigurationModeOne(
      voltage: reader.readString(),
      maxCurrent: reader.readString(),
      passMinCurrent: reader.readString(),
      passMaxCurrent: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionConfigurationModeOne obj) {
    writer.writeString(obj.voltage);
    writer.writeString(obj.maxCurrent);
    writer.writeString(obj.passMinCurrent);
    writer.writeString(obj.passMaxCurrent);
  }
}
