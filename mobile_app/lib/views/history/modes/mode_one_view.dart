import 'package:flutter/material.dart';
import 'package:rvi_analyzer/domain/ModeOneResp.dart';
import 'package:rvi_analyzer/repository/modes_info_repo.dart';
import 'package:rvi_analyzer/service/mode_service.dart';
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
      child: FutureBuilder<ModeOneResp?>(
          future: saveLastModeOne(),
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
                            'Mode One',
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
                                          'Max Current : ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .sessions
                                              .first
                                              .sessionConfigurationModeOne
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
                                          'Voltage : ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!
                                              .sessions
                                              .first
                                              .sessionConfigurationModeOne
                                              .voltage,
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
                          child: Center(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Container(
                                        color: Colors.grey,
                                        child: const Center(
                                            child: Text('TEST ID')),
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
                                        child: const Center(
                                            child: Text('CURRENT')),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        color: Colors.grey,
                                        child: const Center(
                                            child: Text('VOLTAGE')),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        color: Colors.grey,
                                        child:
                                            const Center(child: Text('RESULT')),
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
                                ...snapshot.data!.sessions.first.results
                                    .map((e) {
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
                                              child: Text(e
                                                  .readings.first.temperature)),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                                  e.readings.first.current)),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                                  e.readings.first.voltage)),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                                  e.readings.first.result!)),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                                  e.readings.first.readAt!)),
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
