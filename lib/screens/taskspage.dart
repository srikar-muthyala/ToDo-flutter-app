import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_ui/database_helper.dart';
import 'package:todo_ui/models/task.dart';
import 'package:todo_ui/models/todo.dart';
import 'package:todo_ui/widgets.dart';

class TaskPage extends StatefulWidget {
  final Task task;
  TaskPage({@required this.task});
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  String _taskTitle = "";

  @override
  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                                image: AssetImage(
                                    "assets/images/back_arrow_icon.png")),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (widget.task == null) {
                                  print("create new task");

                                  Task _newTask = Task(
                                    title: value,
                                  );

                                  await _dbHelper.insertTask(_newTask);
                                } else {
                                  print("update the existing task");
                                }
                              }
                            },
                            controller: TextEditingController()
                              ..text = _taskTitle,
                            decoration: InputDecoration(
                              hintText: "enter task title",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff211551),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Description text",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                          )),
                    ),
                  ),
                  FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTodos(),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return TodoWidget(
                              text: snapshot.data[index].title,
                              isDone: false,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: 12,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Color(0xff86829d),
                              width: 1.5,
                            ),
                          ),
                          child: Image(
                            image: AssetImage("assets/images/check_icon.png"),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (widget.task != null) {
                                  print("create new task");
                                  DatabaseHelper _dbHelper = DatabaseHelper();

                                  Todo _newTodo = Todo(
                                    title: value,
                                    isDone: 0,
                                    taskId: widget.task.id,
                                  );

                                  await _dbHelper.insertTodo(_newTodo);
                                  setState(() {});
                                  print("creating new todo");
                                }
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "enter todo item",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Color(0xfffe3577),
                        borderRadius: BorderRadius.circular(20)),
                    child: Image(
                      image: AssetImage("assets/images/delete_icon.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
