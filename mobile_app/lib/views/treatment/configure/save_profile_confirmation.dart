import 'package:rvi_analyzer/domain/profile.dart';
import 'package:rvi_analyzer/service/treatment_profile_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showConfirmationDialog(
    BuildContext context, String message, String key, Profile profile) {
  double width = MediaQuery.of(context).size.width;

  showGeneralDialog(
    context: context,
    pageBuilder: (ctx, a1, a2) {
      return Container();
    },
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: AlertDialog(
          insetPadding: EdgeInsets.all(20),
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          elevation: 40,
          title: Center(
              child: Text(message,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255)))),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 65,
                        width: width - (width / 2 - 20),
                        child: CupertinoButton.filled(
                          padding: const EdgeInsets.all(0),
                          disabledColor: Colors.grey,
                          onPressed: () {
                            saveProfile(profile, key)
                                .then((value) => Navigator.of(context).pop());
                          },
                          child: const Text('Update',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 255, 253, 253))),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 65,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: CupertinoButton(
                            color: const Color.fromARGB(255, 30, 41, 59),
                            padding: const EdgeInsets.all(0),
                            disabledColor: Colors.grey,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
