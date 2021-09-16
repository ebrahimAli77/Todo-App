import 'package:flutter/material.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/custom_widget/my_list_view.dart';
import 'package:to_do/custom_widget/bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:to_do/main.dart';
import 'package:to_do/model/task_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    print('Init called');
    // Future.delayed(delay);
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // loadData();
    Provider.of<TaskData>(context, listen: false)
        .loadData(context, sharedPreferences);
    Provider.of<TaskData>(context, listen: false)
        .loadThemeData(context, sharedPreferences);

    setState(() {});
  }

  //  void saveData () {
  //   List<String> spList = Provider.of<TaskData>(context, listen: false).task.map((item) => jsonEncode(item.toMap())).toList();
  //   sharedPreferences.setStringList('task', spList);
  //   print(spList);
  // }

  // void loadData (){
  //  List<String> spList = sharedPreferences.getStringList('task');
  //  Provider.of<TaskData>(context, listen: false).task = spList.map((item) => Task.fromMap(jsonDecode(item))).toList();
  //  setState(() { });
  // }

  // @override
  // void dispose() {
  //   saveData();
  //   super.dispose();
  // }

  String inputTask;

  String task;

  @override
  Widget build(BuildContext context) {
    bool isSwitched = Provider.of<TaskData>(context, listen: true).themeMode;

    if (isSwitched == null) {
      isSwitched = false;
    }

    double containerRadius = Provider.of<TaskData>(context).containerRadius;

    int taskCount = Provider.of<TaskData>(context).taskCount;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: Colors.amber,
                  )
                ],
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(containerRadius),
                  bottomRight: Radius.circular(containerRadius),
                ),
              ),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 60,
                    // child: Container(
                    //   color: Colors.red,
                    // ),
                  ),
                  Row(
                    children: [
                      Text('$taskCount ',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w800,
                            fontSize: 29,
                            color: Colors.amber,
                          )),
                      Text(
                        '${taskCount <= 1 ? task = 'Task' : task = 'Tasks'} ',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 29,
                          letterSpacing: 1,
                          color: MyApp.white,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (bool value) {
                      setState(() {
                        Provider.of<TaskData>(context, listen: false)
                            .themeMode = value;
                        Provider.of<TaskData>(context, listen: false)
                            .saveThemeData(context, sharedPreferences);
                      });
                      print('');
                    },
                    activeColor: Colors.amber,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.amber,
                  //     radius: 30,
                  //     child: Icon(
                  //       Icons.check_rounded,
                  //       size: 40,
                  //       color: Color(0xff212155),
                  //     ),
                  //   ),
                  //   onTap: (){
                  //     setState(() {
                  //       // MyApp.blue = Colors.white;
                  //       // MyApp.white = Color(0xff212155);
                  //       MyApp.blue == Color(0xff212155) ? MyApp.blue = Colors.white : MyApp.blue = Color(0xff212155);
                  //       MyApp.white == Colors.white ? MyApp.white = Color(0xff212155) : MyApp.white = Colors.white ;
                  //     });
                  //     print('Tapped');
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 18,
                  // ),
                  Text(
                    'To Do',
                    style: kTextStyleMain50.copyWith(color: Colors.amber),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BounceInUp(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.amber,
                              offset: Offset(0, -5),
                            ),
                            // BoxShadow(
                            //   color: Colors.purple,
                            //   offset: Offset(0, -5),
                            // ),
                          ],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(containerRadius),
                            topLeft: Radius.circular(containerRadius),
                          ),
                          color: Theme.of(context).canvasColor,
                        ),
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(containerRadius),
                              topLeft: Radius.circular(containerRadius)),
                          child: MyListView(
                            sharedPreferences: sharedPreferences,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Theme.of(context).canvasColor,
                                  offset: Offset(0, -7),
                                  blurRadius: 6,
                                ),
                              ]),
                          width: double.infinity,
                          height: 45,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(containerRadius),
                                topRight: Radius.circular(containerRadius)),
                          ),
                          width: 300,
                          height: 45,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // saveData();
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => MyBottomSheet(sharedPreferences),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(containerRadius))));
        },
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
