class Todo {
  Todo({
    required this.title,
    required this.creationDate,
    required this.done,
  });

  String title;
  DateTime creationDate;
  bool done = false;

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        creationDate = DateTime.parse(json['creationDate']),
        done = json['done'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'creationDate': creationDate.toIso8601String(),
      'done': done,
    };
  }
}
