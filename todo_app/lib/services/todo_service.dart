import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class TodoService {
  final String baseUrl = 'http://localhost:5000';

  Future<List<Todo>> getTodos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/todos'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      print('Error fetching todos: $e');
      rethrow;
    }
  }

  Future<void> createTodo(String title, String description, DateTime time, DateTime deadline, String priority) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/todos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'description': description,
          'time': time.toIso8601String(),
          'deadline': deadline.toIso8601String(),
          'priority': priority,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to create todo');
      }
    } catch (e) {
      print('Error creating todo: $e');
      rethrow;
    }
  }

  Future<void> updateTodoStatus(String id, bool completed) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/todos/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'completed': completed}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update todo status');
      }
    } catch (e) {
      print('Error updating todo status: $e');
      rethrow;
    }
  }
}
