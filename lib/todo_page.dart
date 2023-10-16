import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_example/services/service_locator.dart';

import 'models/todo.dart';
import 'network/rest_client.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController controller = TextEditingController();
  List<Todo> todoList = [];
  final RestClient client = getIt<RestClient>();

  @override
  void initState() {
    getTodoList();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getTodoList() async {
    try {
      todoList = await client.getTodosByUserId(5);
      setState(() {});
    } on DioException catch (e) {
      debugPrint(e.response?.statusCode.toString());
      debugPrint(e.response?.statusMessage);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void createNewTodo() async {
    try {
      if (controller.text != '') {
        final result = await client.createTodo(
            Todo(userId: 5, title: controller.text, completed: false));
        todoList.add(result);
        setState(() {});
      }
    } on DioException catch (e) {
      debugPrint(e.response?.statusCode.toString());
      debugPrint(e.response?.statusMessage);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: controller,
                  )),
                  ElevatedButton(
                      onPressed: () {
                        createNewTodo();
                      },
                      child: const Text('Create')),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    reverse: true,
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text('${index + 1}'),
                        title: Text(
                          todoList[index].title,
                          style: TextStyle(
                              decoration: todoList[index].completed
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        subtitle: Text(todoList[index].completed
                            ? 'Completed'
                            : 'Incompleted'),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
