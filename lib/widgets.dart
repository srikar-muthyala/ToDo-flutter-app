import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  TaskCardWidget({
    this.title,
    this.desc,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(bottom: 20, right: 24, left: 24),
      child: Stack(
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
              color: Color(0xff211551),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Positioned(
            top: 40,
            child: Text(
              desc ?? "(No Description data)",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff86829d),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  final String text;
  final bool isDone;

  TodoWidget({this.text, @required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 12,
            ),
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: isDone ? Color(0xff7349fe) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: isDone
                  ? null
                  : Border.all(
                      color: Color(0xff86829d),
                      width: 1.5,
                    ),
            ),
            child: Image(
              image: AssetImage("assets/images/check_icon.png"),
            ),
          ),
          Text(
            text ?? '(todo)',
            style: TextStyle(
              color: isDone ? Color(0xff211551) : Color(0xff86829d),
              fontSize: 16,
              fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
