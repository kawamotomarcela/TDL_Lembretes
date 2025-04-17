import 'package:flutter/material.dart';
import '../widgets/date_picker_button.dart';
import '../widgets/time_picker_button.dart';
import '../widgets/rounded_button.dart';

class PaginaLembrete extends StatefulWidget {
  const PaginaLembrete({super.key});

  @override
  State<PaginaLembrete> createState() => _PaginaLembreteState();
}

class _PaginaLembreteState extends State<PaginaLembrete> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _observacoesController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _clearFields() {
    setState(() {
      _nomeController.clear();
      _observacoesController.clear();
      _selectedDate = null;
      _selectedTime = null;
    });
  }

  void _saveReminder() {
    final nome = _nomeController.text.trim();
    final observacoes = _observacoesController.text.trim();

    final data = _selectedDate != null
        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
        : 'Não selecionado';
    final hora = _selectedTime != null
        ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
        : 'Não selecionado';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Lembrete Salvo"),
        content: Text("Nome: $nome\nData: $data\nHora: $hora\nObservações: $observacoes"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _clearFields();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Cadastrar Lembretes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome do Lembrete',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            DatePickerButton(
              selectedDate: _selectedDate,
              onPressed: () => _selectDate(context),
            ),
            const SizedBox(height: 16),
            TimePickerButton(
              selectedTime: _selectedTime,
              onPressed: () => _selectTime(context),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _observacoesController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Observações',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),
            RoundedButton(
              text: 'Salvar Lembrete',
              onPressed: _saveReminder,
            ),
          ],
        ),
      ),
    );
  }
}
