import 'package:flutter/material.dart';

import 'package:og_todo_app/controller/homescreencontroller.dart';
import 'package:og_todo_app/view/splashscreen/splashscreen.dart';

Future<void> main() async {
runApp(MyApp());
WidgetsFlutterBinding.ensureInitialized();
await Homescreencontroller.initDb();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}