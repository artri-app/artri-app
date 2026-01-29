import 'package:flutter/material.dart';

class CustomSimpleDialog extends StatelessWidget {
  final Widget? title;
  final Widget body;
  final List<SimpleDialogOption> actions;

  CustomSimpleDialog({this.title, required this.body, required this.actions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: title, content: body, actions: actions);
  }
}
