import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rvi_analyzer/repository/entity/common_entity.dart';
import 'package:rvi_analyzer/repository/entity/mode_three_entity.dart';
import 'package:rvi_analyzer/repository/modes_info_repo.dart';
import 'package:rvi_analyzer/views/common/line_chart_for_history_view.dart';
import 'package:rvi_analyzer/views/history/modes/default_configurations.dart';

class ModeTwoView extends StatelessWidget {
  final String username;
  ModeTwoView({Key? key, required this.username}) : super(key: key);
  final ModeInfoRepository repo = ModeInfoRepository();

  List<FlSpot> getGraph01data(List<Reading> readings) {
    List<FlSpot> spotData = [];
    for (var element in readings) {
      spotData.add(
          FlSpot(double.parse(element.voltage), double.parse(element.current)));
    }
    return spotData;
  }

  List<FlSpot> getGraph02data(List<Reading> readings) {
    List<FlSpot> spotData = [];
    for (var element in readings) {
      spotData.add(FlSpot(double.parse(element.voltage),
          double.parse(element.voltage) / double.parse(element.current)));
    }
    return spotData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: FutureBuilder<ModeThree?>(
          future: repo.getLastModeThree(username),
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
              if (snapshot.data != null) {
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
                            'Mode Three',
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
                                      config: snapshot
                                          .data!.defaultConfigurations)),
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
                                          'Starting Voltage : ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .sessionConfigurationModeThree
                                              .startingVoltage,
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
                                          'Desired Voltage : ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .sessionConfigurationModeThree
                                              .desiredVoltage,
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
                                          'Max Current : ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .sessionConfigurationModeThree
                                              .maxCurrent,
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
                                          'Voltage Resolution : ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .sessionConfigurationModeThree
                                              .voltageResolution,
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
                                          'Charge In Time : ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .sessionConfigurationModeThree
                                              .chargeInTime,
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
                                xAxisName: "Voltage",
                                spotData: getGraph01data(
                                    snapshot.data!.results.readings),
                                yAxisName: "Current"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: LineChartHistory(
                            data: LineChartHistoryData(
                                xAxisName: "Voltage",
                                spotData: getGraph01data(
                                    snapshot.data!.results.readings),
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
