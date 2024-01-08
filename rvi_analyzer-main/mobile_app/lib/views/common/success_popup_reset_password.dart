import 'package:rvi_analyzer/views/auth/sign_in/sign_in.dart';
import 'package:flutter/material.dart';

Future<void> showSuccessCommonDialogPR(
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
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          elevation: 24,
          title: Text(message,
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          actions: <Widget>[
            TextButton(
              child: const Text('LOGIN'),
              onPressed: () {
                Navigator.pop(context, 'ok');
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
            ),
          ],
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
