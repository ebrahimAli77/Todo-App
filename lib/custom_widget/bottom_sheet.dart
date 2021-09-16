import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:to_do/main.dart';
import 'package:to_do/model/task_data.dart';

class MyBottomSheet extends StatelessWidget {
  final sharedPreferences;

  MyBottomSheet(this.sharedPreferences);

  @override
  Widget build(BuildContext context) {
    String inputTask = '';

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                  Provider.of<TaskData>(context).containerRadius),
              topLeft: Radius.circular(
                  Provider.of<TaskData>(context).containerRadius)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'ADD TASK',
                style: TextStyle(
                    // color: Color(0xff222A4F),
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                autofocus: true,
                cursorColor: Colors.amber,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                  ),
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff212155)),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                onChanged: (value) {
                  inputTask = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                onPressed: () {
                  if (inputTask == '') {
                    Navigator.pop(context);
                  } else {
                    Provider.of<TaskData>(context, listen: false)
                        .addTask(inputTask);
                    Provider.of<TaskData>(context, listen: false)
                        .saveData(context, sharedPreferences);
                    Navigator.pop(context);

                    Provider.of<TaskData>(context, listen: false)
                        .controller
                        .jumpTo(
                          Provider.of<TaskData>(context, listen: false)
                              .controller
                              .position
                              .maxScrollExtent,
                          // curve: Curves.easeOut,
                          // duration: const Duration(milliseconds: 300),
                        );
                  }
                },
                color: Colors.amber,
                child: Text(
                  'ADD',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
