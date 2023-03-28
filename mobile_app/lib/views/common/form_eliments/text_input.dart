import 'package:flutter/material.dart';

class TestInputData {
  final TextEditingController controller;
  final String? Function(String?) validatorFun;
  final String labelText;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final TextInputType inputType;
  final int maxLines;
  final bool enabled;

  TestInputData(
      {required this.controller,
      required this.validatorFun,
      required this.labelText,
      this.textInputAction = TextInputAction.next,
      this.obscureText = false,
      this.inputType = TextInputType.text,
      this.maxLines = 1,
      this.enabled = true});
}

class TextInput extends StatefulWidget {
  final TestInputData data;
  const TextInput({Key? key, required this.data}) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState(data.obscureText);
}

class _TextInputState extends State<TextInput> {
  bool isPasswordVisible;

  _TextInputState(this.isPasswordVisible);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: TextFormField(
        enabled: widget.data.enabled,
        maxLines: widget.data.maxLines,
        style: const TextStyle(color: Colors.black),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: widget.data.textInputAction ?? TextInputAction.next,
        controller: widget.data.controller,
        validator: (val) => widget.data.validatorFun(val),
        obscureText: isPasswordVisible,
        keyboardType: widget.data.inputType,
        decoration: widget.data.obscureText
            ? InputDecoration(
                labelText: widget.data.labelText,
                suffixIcon: IconButton(
                  icon: Icon(
                    !isPasswordVisible && widget.data.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              )
            : InputDecoration(labelText: widget.data.labelText),
      ),
    );
  }
}
