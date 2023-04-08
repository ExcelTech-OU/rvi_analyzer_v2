import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

SnackBar getSnackBar(ContentType contentType, String message, String title) {
  return SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: SizedBox(
      height: 60,
      child: AwesomeSnackbarContent(
        inMaterialBanner: true,
        title: title,
        message: message,
        contentType: contentType,
      ),
    ),
  );
}
