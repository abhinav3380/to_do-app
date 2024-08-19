import 'package:flutter/material.dart';
import 'package:og_todo_app/view/loginscreen/loginscreen.dart';
import 'package:og_todo_app/view/task_added_screen/taskadded_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/homescreencontroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool onCheck = false;
  TextEditingController taskediting = TextEditingController();
  TextEditingController dateediting = TextEditingController();
  @override
  void initState() {
    dataadded();

    super.initState();
  }

  dataadded() async {
    await Homescreencontroller.getData();
    setState(() {});
  }

  delete(int id) async {
    await Homescreencontroller.deleteData(deletetask: id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.task),
                title: Text("Task complted"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("settings"),
              ),
              Spacer(),
               ElevatedButton(
                    onPressed: () async {
                      SharedPreferences preferencess =
                          await SharedPreferences.getInstance();
                      preferencess.clear();
                      preferencess.clear();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text("Signout")),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 24, 51, 74),
      floatingActionButton: CircleAvatar(
        radius: 30,
        child: IconButton(
            onPressed: () {
              onCheck = false;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskAddedscreen(),
                  ));
            },
            icon: Icon(Icons.add)),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu));
          },
        ),
        title: Text(
          "All Lists",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.search_rounded,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.more_vert,
            color: Colors.white
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    ListView.separated(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 29, 96, 114),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.black,
                                        fillColor: WidgetStatePropertyAll(
                                            Colors.white),
                                        value: onCheck,
                                        onChanged: (value) {
                                          setState(() {
                                            onCheck = value!;
                                            delete(Homescreencontroller
                                                .MyTaskList[index]["id"]);
                                          });
                                        },
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            taskediting.text =
                                                Homescreencontroller
                                                    .MyTaskList[index]["name"];
                                            dateediting.text =
                                                Homescreencontroller
                                                    .MyTaskList[index]["date"];
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextField(
                                                      controller: taskediting,
                                                      decoration:
                                                          InputDecoration(),
                                                    ),
                                                    TextField(
                                                      controller: dateediting,
                                                      decoration:
                                                          InputDecoration(),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                await Homescreencontroller.editData(
                                                                    id: Homescreencontroller
                                                                            .MyTaskList[index]
                                                                        ["id"],
                                                                    name: taskediting
                                                                        .text,
                                                                    task: dateediting
                                                                        .text);
                                                                setState(() {});
                                                                Navigator.pop(
                                                                    context);
                                                                setState(() {});
                                                              },
                                                              child: Text(
                                                                  "update")),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  "cancel")),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.edit)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            delete(Homescreencontroller
                                                .MyTaskList[index]["id"]);
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                  Text(
                                      "Task:${Homescreencontroller.MyTaskList[index]["id"]}"),
                                  Text(
                                    Homescreencontroller.MyTaskList[index]
                                        ["name"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    Homescreencontroller.MyTaskList[index]
                                        ["date"],
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: Homescreencontroller.MyTaskList.length),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}