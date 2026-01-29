import 'package:flutter/material.dart';

class CustomSimpleDialogAction extends StatelessWidget {
  final String textButton;
  final Function onClick;

  CustomSimpleDialogAction({required this.textButton, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick(),
      child: Text(textButton),
    );
  }
}
