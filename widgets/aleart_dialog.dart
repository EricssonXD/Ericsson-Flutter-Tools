import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:guidi/languages/require_localization.dart';
import 'package:guidi/misc/theme.dart';

Future<bool> showYesNoDialog(
  BuildContext context, {
  String? title,
  String? content,
  String yesText = "Yes",
  String? noText,
}) async {
  // set up the button

  // show the dialog
  return await showDialog<bool>(
        useRootNavigator: true,
        context: context,
        builder: (BuildContext aleartContext) {
          Widget yesButton = TextButton(
            child: Text(
              yesText,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            onPressed: () => Navigator.of(aleartContext).pop(true),
          );

          Widget noButton = TextButton(
            child: Text(
              noText ?? "",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            onPressed: () => Navigator.of(aleartContext).pop(false),
          );

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: title != null ? Text(title) : null,
            content: content != null ? Text(content) : null,
            actions: [
              if (noText != null) noButton,
              yesButton,
            ],
          );

          return alert;
        },
      ) ??
      false;
}

// Future<String?> showInputDialog(
//   BuildContext context, {
//   Widget? title,
//   String? inputHint,
//   String confirmText = "Confirm",
//   String? cancelText = 'Cancel',
// }) async {
//   TextEditingController textEditingController = TextEditingController();
//   String? inputText;
//   return showDialog<String>(
//     useRootNavigator: true,
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: title,
//         content: TextField(
//           controller: textEditingController,
//           decoration: InputDecoration(hintText: inputHint),
//         ),
//         actions: <Widget>[
//           if (cancelText != null)
//             TextButton(
//               child: Text(
//                 cancelText,
//                 style: const TextStyle(color: GUIDiTheme.darkGrey),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(null);
//               },
//             ),
//           TextButton(
//             child: Text(confirmText,
//                 style: const TextStyle(color: GUIDiTheme.darkGrey)),
//             onPressed: () {
//               inputText = textEditingController.text;
//               Navigator.of(context).pop(inputText);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
Future<String?> showInputDialog(
  BuildContext context, {
  String? title,
  String? inputHint,
  String? confirmText,
  String? cancelText,
  DialogType dialogType = DialogType.info,
}) async {
  TextEditingController textEditingController = TextEditingController();
  String? inputText;
  return await AwesomeDialog(
          context: context,
          useRootNavigator: true,
          autoDismiss: false,
          onDismissCallback: (type) {
            if (type == DismissType.btnOk) {
              inputText = textEditingController.text;
              Navigator.of(context, rootNavigator: true).pop(inputText);
            } else {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          bodyHeaderDistance: 20,
          btnOkText: confirmText ?? MyTexts.confirm,
          btnCancelOnPress: () {},
          btnCancelText: cancelText ?? MyTexts.cancel,
          dialogType: dialogType,
          btnCancelColor: GUIDiTheme.darkGrey,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(hintText: inputHint),
                ),
              ],
            ),
          ),
          btnOkColor: GUIDiTheme.aiGuidedPalette,
          btnOkOnPress: () {})
      .show();
}
