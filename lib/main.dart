import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/model/task_data.dart';
import 'screens/to_do_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Color blue = Color(0xff212155);
  static Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: Consumer<TaskData>(
        builder: (context, taskData, child) {
          return MaterialApp(
            // themeMode: ThemeMode.system,
            theme: taskData.themeMode == true
                ? taskData.lightMode
                : taskData.darkMode,
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: MyBehavior(),
                child: child,
              );
            },
            debugShowCheckedModeBanner: false,
            home: ToDoScreen(),
          );
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
