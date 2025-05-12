import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/widgets/rounded_button.dart';
import '../../../models/task_model.dart';
import 'date_picker_button.dart';
import 'time_picker_button.dart';
import '../../../utils/show_snackbar.dart';

class TaskForm extends StatefulWidget {
  final Function(TaskModel) onSubmit;
  final void Function(String id)? onDelete; 
  final TaskModel? tarefaEditavel;

  const TaskForm({
    super.key,
    required this.onSubmit,
    this.onDelete, 
    this.tarefaEditavel,
  });

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

  @override
  void initState() {
    super.initState();

    final tarefa = widget.tarefaEditavel;
    if (tarefa != null) {
      _titleController.text = tarefa.titulo;
      _notesController.text = tarefa.categoria;
      _selectedDate = tarefa.data;
      _selectedTime = TimeOfDay(hour: tarefa.data.hour, minute: tarefa.data.minute);
      _priority = _intParaPrioridade(tarefa.prioridade);
      _alarmeAtivado = tarefa.alarmeAtivado;
    }
  }

  void _save() {
    final titulo = _titleController.text.trim();
    if (titulo.isEmpty) {
      showSnackBar(context, 'Preencha o título da tarefa.');
      return;
    }

    final now = DateTime.now();
    final date = _selectedDate ?? now;
    final finalDateTime = _selectedTime != null
        ? DateTime(date.year, date.month, date.day, _selectedTime!.hour, _selectedTime!.minute)
        : date;

    final novaTarefa = TaskModel(
      id: widget.tarefaEditavel?.id ?? const Uuid().v4(),
      titulo: titulo,
      data: finalDateTime,
      status: widget.tarefaEditavel?.status ?? StatusTarefa.pendente,
      categoria: _notesController.text.trim(),
      prioridade: _prioridadeParaInt(_priority),
      alarmeAtivado: _alarmeAtivado,
    );

    try {
      widget.onSubmit(novaTarefa);
      Navigator.pop(context);
      showSnackBar(context, widget.tarefaEditavel == null ? 'Tarefa criada com sucesso!' : 'Tarefa atualizada!');
    } catch (e) {
      debugPrint('Erro ao salvar tarefa: $e');
      showSnackBar(context, 'Erro ao salvar tarefa.');
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

  String _intParaPrioridade(int valor) {
    switch (valor) {
      case 3:
        return 'Alta';
      case 2:
        return 'Média';
      case 1:
      default:
        return 'Baixa';
    }
  }

  void _confirmarExclusao() async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Tarefa'),
        content: const Text('Tem certeza que deseja excluir esta tarefa?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirmado == true && widget.tarefaEditavel != null) {
      widget.onDelete?.call(widget.tarefaEditavel!.id);
    }
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
          Text(
            widget.tarefaEditavel == null ? 'Nova Tarefa' : 'Editar Tarefa',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                initialDate: _selectedDate ?? DateTime.now(),
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
                initialTime: _selectedTime ?? TimeOfDay.now(),
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
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Ativar Alarme'),
            value: _alarmeAtivado,
            onChanged: (value) {
              setState(() {
                _alarmeAtivado = value;
              });
              showSnackBar(context, value ? 'Alarme ativado!' : 'Alarme desativado!');
            },
          ),
          const SizedBox(height: 24),
          RoundedButton(
            text: widget.tarefaEditavel == null ? 'Salvar' : 'Atualizar',
            onPressed: _save,
          ),
          const SizedBox(height: 12),
          if (widget.tarefaEditavel != null)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.delete),
              label: const Text('Excluir Tarefa'),
              onPressed: _confirmarExclusao,
            ),
        ],
      ),
    );
  }
}

