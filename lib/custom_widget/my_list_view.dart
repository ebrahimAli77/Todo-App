import 'package:flutter/material.dart';
import 'package:to_do/custom_widget/my_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:to_do/model/task_data.dart';
// import 'package:to_do/screens/to_do_screen.dart';

class MyListView extends StatelessWidget {
  final sharedPreferences;

  MyListView({this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    // int taskCount = Provider.of<TaskData>(context).taskCount;

    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.task[index];
            return MyListTile(
              title: task.name,
              isChecked: task.isDone,
              userToggle: (value) {
                taskData.crossTask(task);
                Provider.of<TaskData>(context, listen: false)
                    .saveData(context, sharedPreferences);
              },
              // onLongPress: () {
              //   taskData.deleteTask(task);
              //   Provider.of<TaskData>(context, listen: false)
              //       .saveData(context, sharedPreferences);
              // },
              onDisMiss: (DismissDirection direction) {
                taskData.deleteTask(task);
                Provider.of<TaskData>(context, listen: false)
                    .saveData(context, sharedPreferences);
                print(direction);
              },
            );
          },
          itemCount: taskData.taskCount,
          reverse: true,
          controller: Provider.of<TaskData>(context).controller,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.all(25),
        );
      },
    );
  }
}
