class task {
  static const String collectionName = "tasks";


String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;
  task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'] as String?,
            title: data['title'] as String?,
            description: data['description'] as String?,
            dateTime: DateTime.fromMicrosecondsSinceEpoch(data['dateTime']),
            isDone: data['isDone'] as bool?);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }
}
