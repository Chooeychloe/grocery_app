import 'package:flutter/material.dart';
import 'package:grocery_app/data/grocery_database.dart';
import 'package:grocery_app/utils/dialog_box.dart';
import 'package:grocery_app/utils/grocery_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:textless/textless.dart';

import '../utils/dialog_box2.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box('myBox');
  GroceryDataBase db = GroceryDataBase();
  final controller = TextEditingController();

  @override
  void initState() {
    if (_myBox.get("GROCERIES") == null) {
      db.createInitialata();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.groceries[index][1] = !db.groceries[index][1];
    });
    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      if (controller.text.isEmpty || controller.text == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No input!"),
        ));
        return;
      } else {
        db.groceries.add([controller.text, false]);
        controller.clear();
        db.updateData();

        Navigator.of(context).pop();
      }
    });
  }

  void addGrocery() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: controller,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop());
        });
  }

  void deleteGrocery(int index) {
    setState(() {
      db.groceries.removeAt(index);
    });
    db.updateData();
  }

  void showGrocery(index) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox2(
              title: db.groceries[index][0],
              onCancel: () => Navigator.of(context).pop());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          height: MediaQuery.of(context).size.height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "Powered by: ".text,
              "Dhan Belgica".text.italic.semiBold.black
            ],
          )),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            addGrocery();
          }),
      appBar: AppBar(
        elevation: 0,
        title: 'Grocery List'.text.bold,
        centerTitle: true,
        backgroundColor: Colors.yellow[300],
      ),
      body: db.groceries.isEmpty
          ? Card(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  'No groceries'.h5.semiBold.color(Colors.red),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Icon(
                    color: Colors.red,
                    Icons.add_shopping_cart,
                    size: MediaQuery.of(context).size.height * 0.05,
                  )
                ],
              )),
            )
          : ListView.builder(
              itemCount: db.groceries.length,
              itemBuilder: (context, index) {
                return GroceryTile(
                  grocery: db.groceries[index][0],
                  isBought: db.groceries[index][1],
                  onTap: () => showGrocery(index),
                  onChanged: (value) => checkBoxChanged(value!, index),
                  deleteGrocery: (context) => deleteGrocery(index),
                );
              },
            ),
    );
  }
}
