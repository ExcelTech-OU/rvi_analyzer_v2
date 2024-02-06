import 'package:flutter/material.dart';

class TestInputData {
  final TextEditingController controller;
  final String? Function(String?) validatorFun;
  final void Function(String)? onComplete;
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
      this.onComplete = null,
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
  State<TextInput> createState() => _TextInputState(data);
}

class _TextInputState extends State<TextInput> {
  late TestInputData data;
  bool isPasswordVisible = false;

  _TextInputState(this.data) {
    isPasswordVisible = data.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: TextFormField(
        enabled: data.enabled,
        maxLines: widget.data.maxLines,
        style: const TextStyle(color: Colors.black),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: data.textInputAction ?? TextInputAction.next,
        controller: data.controller,
        validator: (val) => data.validatorFun(val),
        obscureText: isPasswordVisible,
        keyboardType: widget.data.inputType,
        onEditingComplete: () {
          if (widget.data.onComplete != null) {
            widget.data.onComplete!(data.controller.text);
          }
        },
        decoration: data.obscureText
            ? InputDecoration(
                labelText: data.labelText,
                suffixIcon: IconButton(
                  icon: Icon(
                    !isPasswordVisible && data.obscureText
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
