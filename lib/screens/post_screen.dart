import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_pratice/components/dailogue_box.dart';
import 'package:firebase_pratice/components/listtile_for_notes.dart';
import 'package:firebase_pratice/crud_widgets/post_add_screen.dart';
import 'package:firebase_pratice/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  final searchData = TextEditingController();
  final _databaseRef = FirebaseDatabase(
    databaseURL: 'https://fir-prtice-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).reference().child('NOTES');
  final _updateData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostAddScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.purple,
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Home page",
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${error.toString()}")),
                  );
                });
              },
              icon: Icon(Icons.exit_to_app, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (String value) {
                  setState(() {});
                },
                controller: searchData,
                maxLines: null, // Allows the text field to expand vertically
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
                  ),
                ),
              ),
              10.heightBox,
              Expanded(
                child: FirebaseAnimatedList(
                  query: _databaseRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                    String note = snapshot.child('note').value.toString().toLowerCase();
                    String searchQuery = searchData.text.toString().toLowerCase();
                    if (searchQuery.isNotEmpty) {
                      if (note.contains(searchQuery)) {
                        return NoteTile(
                          id: snapshot.child('id').value.toString(),
                          note: snapshot.child('note').value.toString(),
                          onUpdate: () {
                            _updateData.text = snapshot.child('note').value.toString();
                            DialogueBox().showDialogueBox(
                              context,
                              "Update",
                              [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _databaseRef.child(snapshot.key!).update({'note': _updateData.text}).then((_) {
                                      setState(() {});
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text("Edit"),
                                ),
                              ],
                              _updateData,
                              snapshot.child('note').value.toString(),
                              snapshot.key!,
                            );
                          },
                          onDelete: () {
                            DialogueBox().showDeleteDialogueBox(
                              context,
                              "Delete",
                              [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _databaseRef.child(snapshot.key!).remove().then((_) {
                                      setState(() {});
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                              snapshot.key!,
                            );
                          },
                        );
                      } else {
                        return Container(); // Hide items not matching the search query
                      }
                    }
                    return NoteTile(
                      id: snapshot.child('id').value.toString(),
                      note: snapshot.child('note').value.toString(),
                      onUpdate: () {
                        _updateData.text = snapshot.child('note').value.toString();
                        DialogueBox().showDialogueBox(
                          context,
                          "Update",
                          [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                _databaseRef.child(snapshot.key!).update({'note': _updateData.text}).then((_) {
                                  setState(() {});
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Edit"),
                            ),
                          ],
                          _updateData,
                          snapshot.child('note').value.toString(),
                          snapshot.key!,
                        );
                      },
                      onDelete: () {
                        DialogueBox().showDeleteDialogueBox(
                          context,
                          "Delete",
                          [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                _databaseRef.child(snapshot.key!).remove().then((_) {
                                  setState(() {});
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Delete"),
                            ),
                          ],
                          snapshot.key!,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}