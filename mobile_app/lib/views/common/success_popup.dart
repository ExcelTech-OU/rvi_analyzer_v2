import 'package:rvi_analyzer/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

Future<void> showSuccessCommonDialog(
    BuildContext context, String message) async {
  FocusManager.instance.primaryFocus?.unfocus();

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
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          elevation: 40,
          title: Text(message,
              style: const TextStyle(color: Colors.white, fontSize: 15)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          padding: const EdgeInsets.all(0.0),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, 'OK');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardPage(
                                      initialIndex: 0,
                                    )));
                      },
                      child: const Icon(
                        Icons.cancel_rounded,
                        color: Color.fromARGB(255, 148, 163, 184),
                        size: 45,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
