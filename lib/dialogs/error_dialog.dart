import 'package:flutter/cupertino.dart';
import 'package:weatherapp/dialogs/generic_dialog.dart';

Future<void> showErrorDialogs(
    BuildContext buildContext, String text, void method) {
  return showGenericDialog(
      buildContext: buildContext,
      title: 'Hata !',
      content: text,
      dialogOptionBuilder: () => {"OK": () => method});
}
