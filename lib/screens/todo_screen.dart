// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen(
      {super.key,
      required this.type,
      required this.index,
      required this.text,});

  final String type;
  final int index;
  final String text;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (type == 'update') {
      controller.text = text;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Text(
          type == 'add' ? 'Add Task' : 'Update Task',
          style: const TextStyle(
            color: Colors.blueAccent,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.blueAccent,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                label: const Text('Add Task Content'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                onButtonPressed(controller.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPinkColor),
                fixedSize: MaterialStateProperty.all(
                  const Size(100, 40),
                ),
              ),
              child: Text(type == 'add' ? 'Add' : "Update"),
            ),
          ],
        ),
      ),
    );
  }

  void onButtonPressed(String text) {
    if (type == 'add') {
      add(text);
    } //
    else if (type == 'update') {
      update(text);
    } //
    else if (type == 'delete') {
      remove();
    } //
    // else if (type == 'changeState') {
    //   changeState(text);
    // }
    controller.clear();
  }

  add(String text) async {
    var box = await Hive.openBox('todo');
    Todo todo = Todo(text);
    box.add(todo);
  }

  update(String text) async {
    var box = await Hive.openBox('todo');
    Todo todo = Todo(text,);
    box.putAt(index, todo);
  }

  remove() {
    Box box = Hive.box('todo');
    box.deleteAt(index);
  }

  // changeState(String text, bool state) async {
  //   var box = await Hive.openBox('todo');
  //   Todo todo = Todo(text);
  //   box.putAt(index, todo);
  // }
}
