import 'package:flutter/material.dart';

Future<TimeOfDay?> showHour(BuildContext context) async {
  return showTimePicker(
    initialTime: const TimeOfDay(hour: 08, minute: 00),
    context: context,
    cancelText: 'Cancel',
    confirmText: 'Confirmer',
    helpText: 'Choisissez l\'heure',
    initialEntryMode: TimePickerEntryMode.input,
  );
}
