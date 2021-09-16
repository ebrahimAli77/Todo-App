import 'package:flutter/material.dart';
import 'package:to_do/constants.dart';
import 'package:provider/provider.dart';
import 'package:to_do/model/task_data.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final bool isChecked;
  final Function userToggle;
  // final Function onLongPress;
  final Function onDisMiss;

  MyListTile(
      {this.title,
      this.isChecked,
      this.userToggle,
      // this.onLongPress,
      this.onDisMiss});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Dismissible(
          background: Container(
            color: Colors.red,
          ),
          onDismissed: onDisMiss,
          key: new ValueKey(title),
          child: ListTile(
            // onLongPress: onLongPress,
            contentPadding: EdgeInsets.all(0),
            title: Text(title,
                style: kTextStyleSub18.copyWith(
                    // color: MyApp.blue,
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            trailing: Theme(
              data: ThemeData(
                unselectedWidgetColor: Theme.of(context).disabledColor,
              ),
              child: Checkbox(
                activeColor: Colors.amber,
                checkColor: Color(0xff212155),
                value: isChecked,
                onChanged: userToggle,
              ),
            ),
          ),
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}

// class TaskCheckBox extends StatelessWidget {
//
//   final bool isChecked;
//   final Function toggleCheckBox;
//
//   TaskCheckBox({this.isChecked, this.toggleCheckBox});
//
//   @override
//   Widget build(BuildContext context) {
//     return Checkbox(
//       activeColor: Colors.amber,
//       checkColor: Color(0xff212155),
//       value: isChecked,
//       onChanged: toggleCheckBox,
//     );
//   }
// }
