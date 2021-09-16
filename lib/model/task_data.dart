// import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:to_do/model/task.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TaskData extends ChangeNotifier {
  ThemeData lightMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Color(0xff222A4F),
    primaryColor: Colors.amber,
    accentColor: Color(0xff191F3B),
    canvasColor: Colors.white,
    disabledColor: Colors.black,
  );

  ThemeData darkMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Color(0xff212121),
    accentColor: Color(0xff191919),
    primaryColor: Colors.amber,
    disabledColor: Colors.white,
  );

  bool themeMode;

  var shared;
  var context;

  TaskData({this.shared});

  double containerRadius = 40;

  List<Task> task = [
    Task(name: 'Add by the add button'),
    Task(name: 'Delete by swiping left or right'),
  ];

  // List get task {
  //   return _task;
  // }

  int get taskCount {
    return task.length;
  }

  void addTask(String newTask) {
    var addTask = Task(name: newTask);
    task.add(addTask);
    notifyListeners();
  }

  void crossTask(Task crossTask) {
    crossTask.toggleIsDone();
    notifyListeners();
  }

  void deleteTask(Task deleteTask) {
    task.remove(deleteTask);
    notifyListeners();
  }

  void loadData(context, shared) {
    List<String> spList = shared.getStringList('task');
    Provider.of<TaskData>(context, listen: false).task =
        spList.map((item) => Task.fromMap(jsonDecode(item))).toList();
    print('taskData / loadData called');

    // setState(() { });
  }

  void saveData(context, shared) {
    List<String> spList = Provider.of<TaskData>(context, listen: false)
        .task
        .map((item) => jsonEncode(item.toMap()))
        .toList();
    shared.setStringList('task', spList);
    // print(spList);
    print('taskData / saveData called');
  }

  void saveThemeData(context, shared) {
    shared.setBool('theme', themeMode);
    notifyListeners();
    print(themeMode);
  }

  void loadThemeData(context, shared) {
    themeMode = shared.getBool('theme');
    notifyListeners();
    print(themeMode);
  }

  // double taskNumber = taskCount.toDouble();

  ScrollController controller = ScrollController(initialScrollOffset: 50.0);
}
