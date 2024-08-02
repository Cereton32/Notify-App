import 'package:flutter/material.dart';
class DialogueBox {
  Future<void> showDialogueBox(
      BuildContext context, String title, List<Widget> actions, TextEditingController content, String data, String id) async {
    content.text = data;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: content,
          ),
          actions: actions,
        );
      },
    );
  }

  Future<void> showDeleteDialogueBox(
      BuildContext context, String title, List<Widget> actions, String id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text("Are you sure you want to delete this note?"),
          actions: actions,
        );
      },
    );
  }
}