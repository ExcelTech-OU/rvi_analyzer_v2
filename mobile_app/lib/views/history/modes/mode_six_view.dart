import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rvi_analyzer/domain/ModeSixResp.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/modes_info_repo.dart';
import 'package:rvi_analyzer/service/mode_service.dart';
import 'package:rvi_analyzer/views/common/line_chart_for_history_view.dart';
import 'package:rvi_analyzer/views/history/modes/default_configurations.dart';

class ModeSixView extends StatelessWidget {
  final String username;
  ModeSixView({Key? key, required this.username}) : super(key: key);
  final ModeInfoRepository repo = ModeInfoRepository();

  List<FlSpot> getGraph01data(List<Reading> readings) {
    List<FlSpot> spotData = [];
    for (int i = 0; i < readings.length; i++) {
      var element = readings[i];
      spotData.add(FlSpot(i.toDouble(), double.parse(element.current)));
    }
    return spotData;
  }

  List<FlSpot> getGraph02data(List<Reading> readings) {
    List<FlSpot> spotData = [];
    for (int i = 0; i < readings.length; i++) {
      var element = readings[i];
      spotData.add(FlSpot(i.toDouble(), double.parse(element.voltage)));
    }
    return spotData;
  }

  List<FlSpot> getGraph03data(List<Reading> readings) {
    List<FlSpot> spotData = [];
    for (int i = 0; i < readings.length; i++) {
      var element = readings[i];
      spotData.add(FlSpot(i.toDouble(),
          double.parse(element.voltage) / double.parse(element.current)));
    }
    return spotData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: FutureBuilder<ModeSixResp?>(
          future: getLastModeSix(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error occurred while loading data.'),
              );
            } else {
              if (snapshot.data != null && snapshot.data!.sessions.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 0.5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                          child: Text(
                            'Mode Six',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  child: DefaultConfView(
                                      config: snapshot.data!.sessions.first
                                          .defaultConfigurations)),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Session Configurations',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Text(
                                          'Fixed Current : ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .sessions
                                              .first
                                              .sessionConfigurationModeSix
                                              .fixedCurrent,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Text(
                                          'Max Voltage : ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .sessions
                                              .first
                                              .sessionConfigurationModeSix
                                              .maxVoltage,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Text(
                                          'Time Duration : ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .sessions
                                              .first
                                              .sessionConfigurationModeSix
                                              .timeDuration,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: LineChartHistory(
                            data: LineChartHistoryData(
                                xAxisName: "Time",
                                spotData: getGraph01data(snapshot
                                    .data!.sessions.first.results.readings),
                                yAxisName: "Current"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: LineChartHistory(
                            data: LineChartHistoryData(
                                xAxisName: "Time",
                                spotData: getGraph02data(snapshot
                                    .data!.sessions.first.results.readings),
                                yAxisName: "Voltage"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: LineChartHistory(
                            data: LineChartHistoryData(
                                xAxisName: "Time",
                                spotData: getGraph03data(snapshot
                                    .data!.sessions.first.results.readings),
                                yAxisName: "Resistance"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text("NO session found"),
                );
              }
            }
          }),
    )));
  }
}
