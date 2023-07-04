import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HistorySummary extends StatefulWidget {
  HistorySummary({Key? key}) : super(key: key);

  @override
  State<HistorySummary> createState() => _HistorySummaryState();
}

class _HistorySummaryState extends State<HistorySummary> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: const [
                  Expanded(flex: 1, child: HistoryCard()),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 1, child: HistoryCard()),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 1, child: HistoryCard()),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: const [
                  Expanded(flex: 1, child: HistoryCard()),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 1, child: HistoryCard()),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 1, child: HistoryCard()),
                ]),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 55,
                    child: CupertinoButton(
                      color: Colors.red,
                      disabledColor: Colors.grey,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      child: false
                          ? const SpinKitWave(
                              color: Colors.white,
                              size: 15.0,
                            )
                          : const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 231, 230, 230),
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 55,
                    child: CupertinoButton(
                      color: Colors.cyan,
                      disabledColor: Colors.grey,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      child: false
                          ? const SpinKitWave(
                              color: Colors.white,
                              size: 15.0,
                            )
                          : const Text(
                              'Submit All',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 231, 230, 230),
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Color.fromARGB(255, 34, 197, 94)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Mode 01",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black)),
          ],
        ),
        tileColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: () => {},
      ),
    );
  }
}
