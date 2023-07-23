import 'package:hive/hive.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';

class ModeThreeAdapter extends TypeAdapter<ModeThree> {
  @override
  final int typeId = 9;

  @override
  ModeThree read(BinaryReader reader) {
    final createdBy = reader.readString();
    final defaultConfigurations = DefaultConfiguration(
      customerName: reader.readString(),
      operatorId: reader.readString(),
      batchNo: reader.readString(),
      serialNo: reader.readString(),
      sessionId: reader.readString(),
    );
    final sessionConfigurationModeThree = SessionConfigurationModeThree(
      startingVoltage: reader.readString(),
      desiredVoltage: reader.readString(),
      maxCurrent: reader.readString(),
      voltageResolution: reader.readString(),
      chargeInTime: reader.readString(),
    );

    final results = List<SessionResult>.generate(1, (_) => reader.read());

    final status = reader.readString();

    return ModeThree(
      createdBy: createdBy,
      defaultConfigurations: defaultConfigurations,
      sessionConfigurationModeThree: sessionConfigurationModeThree,
      results: results.first,
      status: status,
    );
  }

  @override
  void write(BinaryWriter writer, ModeThree obj) {
    writer.writeString(obj.createdBy);

    writer.writeString(obj.defaultConfigurations.customerName);
    writer.writeString(obj.defaultConfigurations.operatorId);
    writer.writeString(obj.defaultConfigurations.batchNo);
    writer.writeString(obj.defaultConfigurations.serialNo);
    writer.writeString(obj.defaultConfigurations.sessionId);

    writer.writeString(obj.sessionConfigurationModeThree.startingVoltage);
    writer.writeString(obj.sessionConfigurationModeThree.desiredVoltage);
    writer.writeString(obj.sessionConfigurationModeThree.maxCurrent);
    writer.writeString(obj.sessionConfigurationModeThree.voltageResolution);
    writer.writeString(obj.sessionConfigurationModeThree.chargeInTime);

    writer.write(obj.results);
    writer.writeString(obj.status);
  }
}

class SessionConfigurationModeThreeAdapter
    extends TypeAdapter<SessionConfigurationModeThree> {
  @override
  final int typeId = 10;

  @override
  SessionConfigurationModeThree read(BinaryReader reader) {
    return SessionConfigurationModeThree(
      startingVoltage: reader.readString(),
      desiredVoltage: reader.readString(),
      maxCurrent: reader.readString(),
      voltageResolution: reader.readString(),
      chargeInTime: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionConfigurationModeThree obj) {
    writer.writeString(obj.startingVoltage);
    writer.writeString(obj.desiredVoltage);
    writer.writeString(obj.maxCurrent);
    writer.writeString(obj.voltageResolution);
    writer.writeString(obj.chargeInTime);
  }
}
