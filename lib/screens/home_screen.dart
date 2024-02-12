// ignore_for_file: unnecessary_cast, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/todo_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.blueAccent,
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.blueAccent,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.add_alert,
            color: Colors.blueAccent,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myNavigator(context, 'add', -1, '');
        },
        backgroundColor: kPinkColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What's up, Olivia!",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "TODAY'S TASKS",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: Hive.openBox('todo'),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return todoList();
                  } //
                  else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget todoList() {
    Box todoBox = Hive.box('todo');
    return ValueListenableBuilder(
      valueListenable: todoBox.listenable(),
      builder: (context, Box box, child) {
        if (box.values.isEmpty) {
          return const Center(
            child: Text(
              'No data!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        } //
        else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: todoBox.length,
            itemBuilder: (context, int index) {
              final Todo todo = box.getAt(index);
              return GestureDetector(
                onTap: () {
                  myNavigator(context, 'update', index, todo.text);
                },
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: kDarkBlueColor,
                  child: ListTile(
                    leading: const Icon(
                          Icons.check_circle_rounded
                    ),
                    title: Text(
                      todo.text,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        myNavigator(
                            context, 'delete', index, todo.text);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  myNavigator(context, String type, int index, String text) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoScreen(
          type: type,
          index: index,
          text: text,
        ),
      ),
    );
  }
}
