import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'styles/textStyle.dart';
import 'todo_detail.dart';
import 'package:todo_test_app/model/todo.dart';
import 'package:todo_test_app/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList;
  int count = 0;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = [];
      updateListView();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'My todos',
          style: signInn,
        ),
      ),
      endDrawer: Drawer(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://tvline.com/wp-content/uploads/2016/08/sherlock-season-4-featured-image.jpg?w=620')),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                  ))
            ],
          ),
          SizedBox(height: 8),
          Text(
            'adegborioyedavid@gmail.com',
            style: regular,
          ),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              style: actionButton3,
              child: Text(
                'Sign out',
                style: hsTodo,
              ))
        ]),
      )),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24),
            Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('June 13, 2021', style: regular),
                          Text(
                            'Today',
                            style: veryBold,
                          )
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            navigateToDetail(Todo('','',2),'Add Todo',);
                          },
                          style: actionButton2,
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              SizedBox(width: 16),
                              Text(
                                'Add Todo',
                                style: hsTodo,
                              )
                            ],
                          ))
                    ])),
            SizedBox(height: 20),
            Text('Hi David, you have $count tasks left today', style: medium),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                      color: Color(0xFF151515),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0))),
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: count,
                          itemBuilder: (BuildContext context, int position) {
                            return Card(
                                    color: Color(0xFF151515),
                                    child: ListTile(
                                onTap: () {
                                 navigateToDetail(Todo('','',2),'Edit Todo');
                                },
                                title: Text(this.todoList[position].title, style: signInn),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        this.todoList[position].description,
                                        style: small,
                                      ),
                                      Text(
                                        this.todoList[position].date,
                                        style: small2,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Divider(height: 0.4, color: Colors.grey)
                                    ]),
                                trailing: Icon(
                                  Icons.verified,
                                  color: getPriorityColor(this.todoList[position].priority),
                                ),
                              ),
                            );
                          }))),
            )
          ],
        ),
      ),
    );
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

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Color(0xff00ff19);
        break;

      default:
        return Color(0xff00ff19);
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.verified);
        break;
      case 2:
        return Icon(Icons.verified);
        break;

      default:
        return Icon(Icons.verified);
    }
  }

  void navigateToDetail(Todo todo, String title) async {
    bool result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) =>
            FractionallySizedBox(heightFactor: 0.9, child: AddTaskScreen(todo, title)));

    if (result == true) {
      updateListView();
    }
  }
}
