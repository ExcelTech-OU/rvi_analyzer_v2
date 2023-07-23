import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_two_entity.dart';

class ModeTwoAdapter extends TypeAdapter<ModeTwo> {
  @override
  final int typeId = 7;

  @override
  ModeTwo read(BinaryReader reader) {
    final createdBy = reader.readString();
    final defaultConfigurations = DefaultConfiguration(
      customerName: reader.readString(),
      operatorId: reader.readString(),
      batchNo: reader.readString(),
      serialNo: reader.readString(),
      sessionId: reader.readString(),
    );

    final sessionConfigurationModeTwo = SessionConfigurationModeTwo(
      current: reader.readString(),
      maxVoltage: reader.readString(),
      passMinVoltage: reader.readString(),
      passMaxVoltage: reader.readString(),
    );

    final resultsLength = reader.readInt();
    final results =
        List<SessionResult>.generate(resultsLength, (_) => reader.read());
    final status = reader.readString();

    return ModeTwo(
      createdBy: createdBy,
      defaultConfigurations: defaultConfigurations,
      sessionConfigurationModeTwo: sessionConfigurationModeTwo,
      results: results,
      status: status,
    );
  }

  @override
  void write(BinaryWriter writer, ModeTwo obj) {
    writer.writeString(obj.createdBy);

    writer.writeString(obj.defaultConfigurations.customerName);
    writer.writeString(obj.defaultConfigurations.operatorId);
    writer.writeString(obj.defaultConfigurations.batchNo);
    writer.writeString(obj.defaultConfigurations.serialNo);
    writer.writeString(obj.defaultConfigurations.sessionId);

    writer.writeString(obj.sessionConfigurationModeTwo.current);
    writer.writeString(obj.sessionConfigurationModeTwo.maxVoltage);
    writer.writeString(obj.sessionConfigurationModeTwo.passMinVoltage);
    writer.writeString(obj.sessionConfigurationModeTwo.passMaxVoltage);

    writer.writeInt(obj.results.length);
    obj.results.forEach(writer.write);

    writer.writeString(obj.status);
  }
}

class SessionConfigurationModeTwoAdapter
    extends TypeAdapter<SessionConfigurationModeTwo> {
  @override
  final int typeId = 8;

  @override
  SessionConfigurationModeTwo read(BinaryReader reader) {
    return SessionConfigurationModeTwo(
      current: reader.readString(),
      maxVoltage: reader.readString(),
      passMinVoltage: reader.readString(),
      passMaxVoltage: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionConfigurationModeTwo obj) {
    writer.writeString(obj.current);
    writer.writeString(obj.maxVoltage);
    writer.writeString(obj.passMinVoltage);
    writer.writeString(obj.passMaxVoltage);
  }
}
