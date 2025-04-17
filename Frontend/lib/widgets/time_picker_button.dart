import 'package:flutter/material.dart';
import 'rounded_button.dart';

class TimePickerButton extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final void Function() onPressed;

  const TimePickerButton({
    super.key,
    required this.selectedTime,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final label = selectedTime == null
        ? 'Selecionar Hora'
        : 'Hora: ${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}';

    return RoundedButton(
      text: label,
      onPressed: onPressed,
      backgroundColor: Colors.indigo.shade100,
      textColor: Colors.indigo,
    );
  }
}
