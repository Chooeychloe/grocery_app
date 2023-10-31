import 'package:flutter/material.dart';

import 'package:grocery_app/utils/my_button.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:textless/textless.dart';

import '../data/grocery_database.dart';

class DialogBox2 extends StatefulWidget {
  VoidCallback onCancel;
     String? title;
  DialogBox2({
    Key? key,
    this.title,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<DialogBox2> createState() => _DialogBox2State();
}

class _DialogBox2State extends State<DialogBox2> {
  final _myBox = Hive.box('myBox');
  GroceryDataBase db = GroceryDataBase();


  @override
  void initState() {
    if (_myBox.get("GROCERIES") == null) {
      db.createInitialata();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[100],
      content: Container(
        height: MediaQuery.sizeOf(context).height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 10,
            ),
           widget.title!.s1,
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(text: 'Close', onPressed: widget.onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
