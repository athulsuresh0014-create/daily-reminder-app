class Task {
  String title;

  int durationDays;

  DateTime createdDate;

  bool archived;

  // Store completed dates
  List<String> completedDates;

  Task({
    required this.title,

    required this.durationDays,

    required this.createdDate,

    this.archived = false,

    List<String>? completedDates,
  }) : completedDates = completedDates ?? [];

  int get currentDay {
    return DateTime.now().difference(createdDate).inDays + 1;
  }

  bool isCompletedToday() {
    String today = DateTime.now().toIso8601String().split('T')[0];

    print("TODAY: $today");
    print("SAVED DATES: $completedDates");

    return completedDates.contains(today);
  }

  void completeToday() {
    String today = DateTime.now().toIso8601String().split('T')[0];

    if (!completedDates.contains(today)) {
      completedDates = [...completedDates, today];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,

      "durationDays": durationDays,

      "createdDate": createdDate.toIso8601String(),

      "archived": archived,

      "completedDates": completedDates,
    };
  }

  factory Task.fromMap(Map map) {
    return Task(
      title: map["title"],

      durationDays: map["durationDays"],

      createdDate: DateTime.parse(map["createdDate"]),

      archived: map["archived"] ?? false,

      completedDates: (map["completedDates"] ?? []).cast<String>(),
    );
  }
}
