import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:grupotdl/pages/tasks/task_list_page.dart';
import 'package:grupotdl/providers/task_provider.dart';
import 'package:grupotdl/services/task_service.dart';

import 'package:mockito/annotations.dart';

@GenerateMocks([TaskService])
import 'task_list_page_test.mocks.dart';

void main() {
  late MockTaskService mockTaskService;

  setUp(() {
    mockTaskService = MockTaskService();
  });

  testWidgets('Renderiza TaskListPage e encontra campo de busca',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<TaskProvider>(
          create: (_) => TaskProvider(taskService: mockTaskService),
          child: const TaskListPage(),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Buscar tarefas...'), findsOneWidget);
  });
}
