import 'package:flutter/material.dart';

class Note {
  String id;
  String content;

  Note({
    required this.id,
    required this.content,
  });
}
class NoteTile extends StatelessWidget {
  final String id;
  final String note;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const NoteTile({
    Key? key,
    required this.id,
    required this.note,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey[300]!, width: 1.0),
      ),
      title: Text(
        note,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blueAccent),
            onPressed: onUpdate,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}