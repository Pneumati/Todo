class Todo {
  final String id;
  final String title;
  final String description;
  final DateTime time;
  final DateTime deadline;
  final String priority;
  late final bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.deadline,
    required this.priority,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      time: DateTime.parse(json['time']),
      deadline: DateTime.parse(json['deadline']),
      priority: json['priority'],
      completed: json['completed'],
    );
  }
}
