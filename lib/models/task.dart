class Task {
  String title;
  bool completed;
  int durationDays;
  DateTime createdDate;

  Task({
    required this.title,
    this.completed = false,
    required this.durationDays,
    required this.createdDate,
  });

  int get currentDay {
    return DateTime.now().difference(createdDate).inDays + 1;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'completed': completed,
      'durationDays': durationDays,
      'createdDate': createdDate.toIso8601String(),
    };
  }

  factory Task.fromMap(Map map) {
    return Task(
      title: map['title'],
      completed: map['completed'],
      durationDays: map['durationDays'],
      createdDate: DateTime.parse(map['createdDate']),
    );
  }
}
