import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/rounded_button.dart';
import '../../../models/task_model.dart';
import 'date_picker_button.dart';
import 'time_picker_button.dart';
import '../../../utils/show_snackbar.dart';
import '../../../providers/task_provider.dart' as tp;

class TaskForm extends StatefulWidget {
  final TaskModel? tarefaEditavel;
  final void Function(TaskModel task) onSubmit;
  final void Function(String id)? onDelete;

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
  final TextEditingController _descricaoController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  PrioridadeTarefa _prioridade = PrioridadeTarefa.media;
  bool _alarmeAtivado = false;

  @override
  void initState() {
    super.initState();

    final tarefa = widget.tarefaEditavel;
    if (tarefa != null) {
      _titleController.text = tarefa.titulo;
      _descricaoController.text = tarefa.descricao;
      _selectedDate = tarefa.dataFinalizacao;
      _selectedTime = TimeOfDay(
        hour: tarefa.dataFinalizacao.hour,
        minute: tarefa.dataFinalizacao.minute,
      );
      _prioridade = tarefa.prioridade;
      _alarmeAtivado = tarefa.alarmeAtivado;
    }
  }

  Future<void> _save() async {
    final titulo = _titleController.text.trim();
    final descricao = _descricaoController.text.trim();

    if (titulo.isEmpty) {
      showSnackBar(context, 'Preencha o título da tarefa.');
      return;
    }

    final now = DateTime.now();
    final selectedDate = _selectedDate ?? now;
    final finalDateTime = _selectedTime != null
        ? DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            _selectedTime!.hour,
            _selectedTime!.minute,
          )
        : selectedDate;

    final novaTarefa = TaskModel(
      id: widget.tarefaEditavel?.id ?? const Uuid().v4(),
      titulo: titulo,
      descricao: descricao,
      dataCriacao: widget.tarefaEditavel?.dataCriacao ?? now,
      dataFinalizacao: finalDateTime,
      status: widget.tarefaEditavel?.status ?? StatusTarefa.emAndamento,
      prioridade: _prioridade,
      alarmeAtivado: _alarmeAtivado,
    );

    try {
      final provider =
          Provider.of<tp.TaskProvider>(context, listen: false);

      if (widget.tarefaEditavel == null) {
        await provider.adicionar(novaTarefa);
        if (!mounted) return;
        showSnackBar(context, 'Tarefa criada com sucesso!');
      } else {
        await provider.editar(novaTarefa);
        if (!mounted) return;
        showSnackBar(context, 'Tarefa atualizada!');
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        debugPrint('Erro ao salvar tarefa: $e');
        showSnackBar(context, 'Erro ao salvar tarefa.');
      }
    }
  }

  void _confirmarExclusao() async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Tarefa'),
        content: const Text(
          'Tem certeza que deseja excluir esta tarefa?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Excluir',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmado == true && widget.tarefaEditavel != null) {
      widget.onDelete?.call(widget.tarefaEditavel!.id);
    }
  }

  InputDecoration _inputDecoration(
    BuildContext context,
    String label,
  ) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: primary,
          width: 1.8,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final textColor = theme.colorScheme.onSurface;

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
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Text(
            widget.tarefaEditavel == null
                ? 'Nova Tarefa'
                : 'Editar Tarefa',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            widget.tarefaEditavel == null
                ? 'Defina um título, prazo e prioridade.'
                : 'Atualize os dados da sua tarefa.',
            style: TextStyle(
              fontSize: 13,
              color: textColor.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _titleController,
            decoration: _inputDecoration(
              context,
              'Título da Tarefa',
            ),
          ),
          const SizedBox(height: 16),

          Text(
            'Data de vencimento',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor.withValues(alpha: 0.9),
            ),
          ),
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
              if (picked != null) {
                setState(() => _selectedDate = picked);
              }
            },
          ),
          const SizedBox(height: 16),

          Text(
            'Hora de vencimento',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 8),
          TimePickerButton(
            selectedTime: _selectedTime,
            onPressed: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _selectedTime ?? TimeOfDay.now(),
              );
              if (picked != null) {
                setState(() => _selectedTime = picked);
              }
            },
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _descricaoController,
            maxLines: 3,
            decoration: _inputDecoration(
              context,
              'Descrição da Tarefa',
            ),
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<PrioridadeTarefa>(
            initialValue: _prioridade,
            decoration: _inputDecoration(
              context,
              'Prioridade',
            ),
            items: PrioridadeTarefa.values.map((p) {
              final label =
                  p.name[0].toUpperCase() + p.name.substring(1);
              return DropdownMenuItem(
                value: p,
                child: Text(label),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _prioridade = value);
              }
            },
          ),
          const SizedBox(height: 8),

          SwitchListTile(
            title: const Text('Ativar alarme'),
            value: _alarmeAtivado,
            activeThumbColor: primary,
            onChanged: (value) {
              setState(() => _alarmeAtivado = value);
              showSnackBar(
                context,
                value ? 'Alarme ativado!' : 'Alarme desativado!',
              );
            },
          ),
          const SizedBox(height: 20),

          RoundedButton(
            text: widget.tarefaEditavel == null
                ? 'Salvar'
                : 'Atualizar',
            onPressed: _save,
          ),
          const SizedBox(height: 12),

          if (widget.tarefaEditavel != null)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.delete),
              label: const Text('Excluir tarefa'),
              onPressed: _confirmarExclusao,
            ),
        ],
      ),
    );
  }
}

