import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/widgets/rounded_button.dart';
import '../../../models/task_model.dart';
import 'date_picker_button.dart';
import 'time_picker_button.dart';
import '../../../utils/show_snackbar.dart';

class TaskForm extends StatefulWidget {
  final Function(TaskModel) onSubmit;

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
  bool _alarmeAtivado = false;

  void _save() {
    final titulo = _titleController.text.trim();

    if (titulo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha o título da tarefa.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final now = DateTime.now();
    final date = _selectedDate ?? now;
    final time = _selectedTime != null
        ? DateTime(
            date.year,
            date.month,
            date.day,
            _selectedTime!.hour,
            _selectedTime!.minute,
          )
        : date;

    final novaTarefa = TaskModel(
      id: const Uuid().v4(),
      titulo: titulo,
      data: time,
      status: StatusTarefa.pendente,
      categoria: _notesController.text.trim(),
      prioridade: _prioridadeParaInt(_priority),
      alarmeAtivado: _alarmeAtivado,
    );

    try {
      widget.onSubmit(novaTarefa);
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Erro ao adicionar tarefa: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao adicionar tarefa.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  int _prioridadeParaInt(String valor) {
    switch (valor) {
      case 'Alta':
        return 3;
      case 'Média':
        return 2;
      case 'Baixa':
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) {
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                  labelText: 'Notas (Categoria)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _priority,
                decoration: InputDecoration(
                  labelText: 'Prioridade',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: ['Alta', 'Média', 'Baixa'].map((prioridade) {
                  return DropdownMenuItem(
                    value: prioridade,
                    child: Text(prioridade),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _priority = value!),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Ativar Alarme'),
                value: _alarmeAtivado,
                onChanged: (value) {
                  setState(() {
                    _alarmeAtivado = value;
                  });
                  showSnackBar(
                    scaffoldContext,
                    value ? 'Alarme ativado!' : 'Alarme desativado!',
                  );
                },
              ),
              const SizedBox(height: 24),
              RoundedButton(text: 'Salvar', onPressed: _save),
            ],
          ),
        );
      },
    );
  }
}

