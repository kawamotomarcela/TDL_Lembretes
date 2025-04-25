import 'package:flutter/material.dart';
import '../../../shared/widgets/rounded_button.dart';

class DatePickerButton extends StatelessWidget {
  final DateTime? selectedDate;
  final void Function() onPressed;

  const DatePickerButton({
    super.key,
    required this.selectedDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final label = selectedDate == null
        ? 'Selecionar Data'
        : 'Data: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';

    return RoundedButton(
      text: label,
      onPressed: onPressed,
      backgroundColor: Colors.indigo.shade100,
      textColor: Colors.indigo,
    );
  }
}
