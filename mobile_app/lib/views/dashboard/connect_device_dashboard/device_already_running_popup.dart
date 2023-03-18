import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rvi_analyzer/providers/device_state_provider.dart';
import 'package:rvi_analyzer/service/common_service.dart';
import 'package:rvi_analyzer/service/flutter_blue_service_impl.dart';

class DeviceRunningStop {
  Blue blue = Blue();

  Future<void> showRunningStopPopup(
      BuildContext context, ScanResult scanResult, String header) async {
    bool scanPressed = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Consumer(builder: ((context, ref, child) {
            return AlertDialog(
                backgroundColor: Colors.black,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                elevation: 24.0,
                title: Center(
                    child: Text(header,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)))),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Center(
                        child: Text('Are you Want to stop?',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CupertinoButton(
                                color: Colors.red,
                                disabledColor:
                                    Color.fromARGB(255, 101, 102, 100),
                                padding: const EdgeInsets.all(10),
                                onPressed: scanPressed
                                    ? null
                                    : () {
                                        setState(
                                          () => scanPressed = true,
                                        );
                                        blue
                                            .write(
                                                scanResult.device,
                                                [0x00, 0x01],
                                                "f0000009-0451-4000-b000-000000000000",
                                                "f0000010-0451-4000-b000-000000000000")
                                            .then((value) => {
                                                  if (value)
                                                    {
                                                      ref
                                                          .read(ref
                                                              .read(deviceDataMap[
                                                                  scanResult
                                                                      .device
                                                                      .name]!)
                                                              .streamData)
                                                          .setStateStop(),
                                                      Navigator.pop(
                                                          context, 'OK'),
                                                    }
                                                  else
                                                    {
                                                      showErrorDialog(context,
                                                          "Something went wrong. Please try again")
                                                    }
                                                });
                                      },
                                child: scanPressed
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.white)
                                    : const Text('Stop',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: CupertinoButton.filled(
                                padding: const EdgeInsets.all(10),
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('Cancel',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                              ),
                            ),
                          ]))
                ]);
          }));
        });
      },
    );
  }
}
