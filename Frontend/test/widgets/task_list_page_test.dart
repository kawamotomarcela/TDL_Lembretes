import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:grupotdl/pages/tasks/task_list_page.dart';
import 'package:grupotdl/providers/task_provider.dart';

void main() {
  testWidgets('Renderiza TaskListPage e encontra campo de busca', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: const MaterialApp(
          home: TaskListPage(),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Buscar tarefas...'), findsOneWidget);
  });
}
