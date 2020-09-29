import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/task.dart';
import 'models/todo.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, desc TEXT)",
        );
        await db.execute(
          "CREATE TABLE todo(id INTEGER PRIMARY KEY, taskId INTEGER , title TEXT, isDone INTEGER)",
        );
        return db;
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    Database _db = await database();
    await _db.insert(
      'tasks',
      task.ToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await database();
    await _db.insert(
      'todo',
      todo.ToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Task(
          id: taskMap[index]['id'],
          title: taskMap[index]['title'],
          desc: taskMap[index]['desc']);
    });
  }

  Future<List<Todo>> getTodos() async {
    Database _db = await database();
    List<Map<String, dynamic>> todoMap = await _db.query('todo');
    return List.generate(todoMap.length, (index) {
      return Todo(
        id: todoMap[index]['id'],
        title: todoMap[index]['title'],
        taskId: todoMap[index]['taskId'],
        isDone: todoMap[index]['isDone'],
      );
    });
  }
}
