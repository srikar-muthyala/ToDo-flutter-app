class Todo {
  final int id;
  final String title;
  final int isDone;
  final int taskId;

  Todo({this.id, this.isDone, this.title, this.taskId});

  Map<String, dynamic> ToMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'taskId': taskId,
    };
  }
}
