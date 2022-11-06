class Todo {
  Todo({
    required this.title,
    required this.creationDate,
  });

  String title;
  DateTime creationDate;

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        creationDate = DateTime.parse(json['creationDate']);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'creationDate': creationDate.toIso8601String(),
    };
  }
}
