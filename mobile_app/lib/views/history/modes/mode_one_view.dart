import 'package:flutter/material.dart';
import 'package:rvi_analyzer/repository/entity/mode_one_entity.dart';
import 'package:rvi_analyzer/repository/modes_info_repo.dart';
import 'package:rvi_analyzer/views/history/modes/default_configurations.dart';

class ModeOneView extends StatelessWidget {
  final String username;
  ModeOneView({Key? key, required this.username}) : super(key: key);
  final ModeInfoRepository repo = ModeInfoRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: FutureBuilder<ModeOne?>(
          future: repo.getLastModeOne(username),
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: DefaultConfView(
                                  config:
                                      snapshot.data!.defaultConfigurations)),
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
                                      'Max Current : ',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      snapshot.data!.sessionConfigurationModeOne
                                          .maxCurrent,
                                      style: const TextStyle(
                                          fontSize: 14.0, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    const Text(
                                      'Voltage : ',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      snapshot.data!.sessionConfigurationModeOne
                                          .voltage,
                                      style: const TextStyle(
                                          fontSize: 14.0, color: Colors.grey),
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
                      child: Center(
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    color: Colors.grey,
                                    child: const Center(child: Text('TEST ID')),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: Colors.grey,
                                    child: const Center(
                                        child: Text('TEMPERATURE')),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: Colors.grey,
                                    child: const Center(child: Text('CURRENT')),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: Colors.grey,
                                    child: const Center(child: Text('VOLTAGE')),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: Colors.grey,
                                    child: const Center(child: Text('RESULT')),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: Colors.grey,
                                    child: const Center(
                                        child: Text('READ DATE TIME')),
                                  ),
                                ),
                              ],
                            ),
                            ...snapshot.data!.results.map((e) {
                              return TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      child: Center(child: Text(e.testId)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                              e.readings.first.temperature)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      child: Center(
                                          child:
                                              Text(e.readings.first.current)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      child: Center(
                                          child:
                                              Text(e.readings.first.voltage)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      child: Center(
                                          child:
                                              Text(e.readings.first.result!)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      child: Center(
                                          child:
                                              Text(e.readings.first.readAt!)),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
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
