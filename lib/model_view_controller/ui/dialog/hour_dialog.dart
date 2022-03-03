import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

Future<TimeOfDay?> showHour(BuildContext context) async {
  return showTimePicker(
    initialTime: const TimeOfDay(hour: 08, minute: 00),
    context: context,
    cancelText: 'Cancel'.tr,
    confirmText: 'Confirmer'.tr,
    helpText: "Choisissez l'heure".tr,
    initialEntryMode: TimePickerEntryMode.input,
  );
}
