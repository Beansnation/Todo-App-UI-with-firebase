import 'package:flutter/material.dart';
import 'package:todo_test_app/model/todo.dart';
import 'home_screen.dart';
import 'styles/textStyle.dart';
import 'package:todo_test_app/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:intl/intl.dart';


class AddTaskScreen extends StatefulWidget {

  final String modalTitle;
  final Todo todo;
  AddTaskScreen(this.todo, this.modalTitle);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState(this.todo, this.modalTitle);
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Todo> todoList;
  String modalTitle;
  Todo todo;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int count;

  _AddTaskScreenState(this.todo, this.modalTitle);

  var priorities = ['High', 'Low'];
  String prior = 'Low';
  int position;

  @override
  Widget build(BuildContext context,) {
    if (todoList == null) {
      todoList = [];
      updateListView();
    }

    titleController.text = todo.title;
    descriptionController.text = todo.description;
    return Container(
      color: Color(0xff0a0a0a),
      child: Expanded(
              child: Container(
          height: 1200,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Color(0xFF222222),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(modalTitle, style: veryBold),
                        GestureDetector(
                          onTap: (){
                           setState(() {
                            delete();
                            _delete(context, todoList[position]);
                           });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Color(0xff00A925),
                          ),
                        )
                      ]),
                  SizedBox(height: 16),
                  Text(
                    'Priority',
                    style: bold,
                  ),
                  SizedBox(height: 4),
                  DropdownButton(
                      value: getPriorityAsString(todo.priority),
                      items: priorities.map((String priority) {
                        return DropdownMenuItem(
                          child: Text(priority),
                          value: priority,
                        );
                      }).toList(),
                      style: medium,
                      onChanged: (String newPrior) {
                        setState(() {
                          updatePriorityAsInt(newPrior);
                        });
                      }),
                  SizedBox(height: 8),
                  Text(
                    'Title',
                    style: bold,
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration: kdecoration('Add a title'),
                    onChanged: (value){
                      updateTitle();
                    },
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description',
                    style: bold,
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    decoration: kdecoration('describe your todo'),
                    onChanged: (value){
                      updateDescription();
                    },
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                         _save();
                      });
                     
                    },
                    child: Text(
                      'Finish',
                      style: signInn,
                    ),
                    style: actionButton,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void _delete(BuildContext context, Todo todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'Todo Deleted Successfully');
      updateListView();
    }
  }

   void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
 void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        todo.priority = 1;
        break;
      case 'Low':
        todo.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = priorities[0];  // 'High'
        break;
      case 2:
        priority = priorities[1];  // 'Low'
        break;
    }
    return priority;
  }

  // Update the title of Tddo object
  void updateTitle(){
    todo.title = titleController.text;
  }

  // Update the description of Todo object
  void updateDescription() {
    todo.description = descriptionController.text;
  }
  void moveToLastScreen() {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }
  void _save() async {

    moveToLastScreen();

    todo.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (todo.id != null) {  // Case 1: Update operation
      result = await databaseHelper.updateTodo(todo);
    } else { // Case 2: Insert Operation
      result = await databaseHelper.insertTodo(todo);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Todo Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Todo');
    }

  }

  void delete() async {

    moveToLastScreen();

    if (todo.id == null) {
      _showAlertDialog('Status', 'No Todo was deleted');
      return;
    }

    // Case 2: User is trying to delete the old todo that already has a valid ID.
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Todo Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Todo');
    }
  }

void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}


