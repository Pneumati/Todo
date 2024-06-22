import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/todo.dart';
import 'services/todo_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TodoService todoService = TodoService();
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    try {
      todos = await todoService.getTodos();
      setState(() {});
    } catch (e) {
      print('Error fetching todos: $e');
    }
  }

  Future<void> _addTodo() async {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    DateTime _selectedTime = DateTime.now();
    DateTime _selectedDeadline = DateTime.now();
    String _selectedPriority = 'Low';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('New Todo'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(hintText: "Todo title"),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(hintText: "Todo description"),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Time: ${DateFormat.yMd().add_jm().format(_selectedTime)}"),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedTime,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null && picked != _selectedTime) {
                              setState(() {
                                _selectedTime = picked;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Deadline: ${DateFormat.yMd().add_jm().format(_selectedDeadline)}"),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDeadline,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null && picked != _selectedDeadline) {
                              setState(() {
                                _selectedDeadline = picked;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      value: _selectedPriority,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPriority = newValue!;
                        });
                      },
                      items: <String>['Low', 'Medium', 'High']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('ADD'),
                  onPressed: () async {
                    if (_titleController.text.isNotEmpty) {
                      try {
                        await todoService.createTodo(
                          _titleController.text,
                          _descriptionController.text,
                          _selectedTime,
                          _selectedDeadline,
                          _selectedPriority,
                        );
                        fetchTodos();
                        Navigator.of(context).pop();
                      } catch (e) {
                        print('Error adding todo: $e');
                      }
                    } else {
                      print('Title is required');
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _toggleTodoCompletion(String id, bool completed) async {
    try {
      await todoService.updateTodoStatus(id, !completed);
      fetchTodos();
    } catch (e) {
      print('Error updating todo status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              title: Text(todos[index].title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(todos[index].description),
                  SizedBox(height: 4.0),
                  Row(
                    children: <Widget>[
                      Text('Time: ${DateFormat.yMd().add_jm().format(todos[index].time)}'),
                      SizedBox(width: 16.0),
                      Text('Deadline: ${DateFormat.yMd().add_jm().format(todos[index].deadline)}'),
                    ],
                  ),
                  Text('Priority: ${todos[index].priority}'),
                ],
              ),
              trailing: Checkbox(
                value: todos[index].completed,
                onChanged: (bool? value) {
                  _toggleTodoCompletion(todos[index].id, todos[index].completed);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
