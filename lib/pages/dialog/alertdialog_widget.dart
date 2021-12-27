import 'package:flutter/material.dart';

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
        FlatButton(
          onPressed: declineFunction,
          child: Text("Retour"),
        ),
        FlatButton(
          onPressed: confirmFunction,
          child: Text("Continue", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
