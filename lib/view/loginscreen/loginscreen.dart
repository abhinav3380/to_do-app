import 'package:flutter/material.dart';
import 'package:og_todo_app/view/homescreen/homescreen.dart';

import 'package:og_todo_app/view/splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  late final SharedPreferences preferencess;
  @override
  void initState() {
    loginAccount();
   
    super.initState();
  }

  loginAccount() async {
    preferencess = await SharedPreferences.getInstance();
    bool isLogedIn = await preferencess.getBool("login") ?? false;
    if (isLogedIn) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    }
    setState(() {});
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Login To MyTodo",
              style: TextStyle(color: Colors.blue, fontSize: 30),
            )),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  hintText: "email",
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passcontroller,
              decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4))),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () async {
                    await preferencess.setString("email", emailcontroller.text);
                    await preferencess.setString(
                        "password", passcontroller.text);
                    await preferencess.setBool("login", true);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Splashscreen(),
                        ));
                  },
                  child: Text("Login")),
            )
          ],
        ),
      ),
    );
  }
}