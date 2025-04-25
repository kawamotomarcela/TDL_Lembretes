import 'package:flutter/material.dart';
import 'date_picker_button.dart';
import 'time_picker_button.dart';
import '../../../shared/widgets/rounded_button.dart';

class TaskForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const TaskForm({super.key, required this.onSubmit});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _priority = 'Média';

  void _save() {
    if (_titleController.text.trim().isEmpty) return;

    final item = {
      'title': _titleController.text.trim(),
      'subtitle': _notesController.text.trim(),
      'priority': _priority,
      'done': false,
      'dateTime': _formatDateTime(),
    };

    widget.onSubmit(item);
    Navigator.pop(context);
  }

  String _formatDateTime() {
    final date = _selectedDate != null
        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
        : 'Sem data';

    final time = _selectedTime != null
        ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
        : 'Sem hora';

    return '$date às $time';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Text(
            'Nova Tarefa',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Título da Tarefa',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Data de Vencimento'),
          const SizedBox(height: 8),
          DatePickerButton(
            selectedDate: _selectedDate,
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) setState(() => _selectedDate = picked);
            },
          ),
          const SizedBox(height: 16),
          const Text('Hora de Vencimento'),
          const SizedBox(height: 8),
          TimePickerButton(
            selectedTime: _selectedTime,
            onPressed: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) setState(() => _selectedTime = picked);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Notas',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _priority,
            decoration: InputDecoration(
              labelText: 'Prioridade',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: ['Alta', 'Média', 'Baixa'].map((prioridade) {
              return DropdownMenuItem(value: prioridade, child: Text(prioridade));
            }).toList(),
            onChanged: (value) => setState(() => _priority = value!),
          ),
          const SizedBox(height: 24),
          RoundedButton(
            text: 'Salvar',
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}
