import 'package:flutter/material.dart';

class AlarmSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AlarmSwitch({ 
    super.key, 
    required this.value, 
    required this.onChanged 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Alarme'),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
