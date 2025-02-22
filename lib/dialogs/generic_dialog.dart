import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>(
    {required BuildContext buildContext,
    required String title,
    required String content,
    required DialogOptionBuilder dialogOptionBuilder}) {
  final options = dialogOptionBuilder();
  return showDialog(
      context: buildContext,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: options.keys.map((i) {
            final value = options[i];
            return TextButton(
                onPressed: () {
                  value;
                  Navigator.of(context).pop();
                },
                child: Text(i));
          }).toList(),
        );
      });
}
