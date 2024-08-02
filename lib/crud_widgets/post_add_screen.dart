import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_pratice/components/round_button.dart';  // Ensure this path is correct

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({super.key});

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  final addPostData = TextEditingController();
  final _databaseRef = FirebaseDatabase(
    databaseURL: 'https://fir-prtice-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).reference().child('NOTES');
  int temp = 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Add Note'),
      ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: addPostData,
              maxLines: null, // Allows the text field to expand vertically
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your notes here...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            RoundButton(
              name: "Add Note",
              ontap: () {
                String noteId = _databaseRef.push().key!;
                _databaseRef.child(noteId).set({
                  'id': noteId,
                  'note': addPostData.text.toString(),
                }).then((_) {
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Note added successfully')),
                  );
                  Navigator.pop(context);
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add note: $error')),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
