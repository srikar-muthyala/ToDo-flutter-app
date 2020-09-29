class Task {
  int id;
  String title;
  String desc;
  Task({this.id, this.title, this.desc});

  Map<String, dynamic> ToMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
    };
  }
}
