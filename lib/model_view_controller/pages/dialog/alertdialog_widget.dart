import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AlertDialogWidget extends StatelessWidget {
  final String contentText;
  final void Function() confirmFunction;
  final void Function() declineFunction;

  AlertDialogWidget({
    required this.contentText,
    required this.confirmFunction,
    required this.declineFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        contentText,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          onPressed: declineFunction,
          child: Text("Retour".tr,
              style: const TextStyle(
                color: Colors.black,
              )),
        ),
        TextButton(
          onPressed: confirmFunction,
          child: Text("Continue".tr, style: const TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
