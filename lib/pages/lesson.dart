import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learningplus/pages/adduser2.dart';
import 'package:learningplus/pages/edituser2.dart';
import 'package:learningplus/pages/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Lesson extends StatefulWidget {
  const Lesson({super.key, required String username, required String password});

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  List<dynamic> users = [];

  int index = 0;
  bool isMenuOpen = false;
  bool areButtonsVisible = false;

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Future<void> getUsers() async {
    const urlstr = "http://172.21.241.49/learningplus/select.php";

    final url = Uri.parse(urlstr);
    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      //Successful
      final json = response.body;
      final data = jsonDecode(json);
      debugPrint('Data: $data');
      setState(() {
        users = data;
      });
    } else {
      //Error
    }
  }

  Future delUser(username) async {
    // var url = 'https://pattyteacher.000webhostapp.com/edit.php';
    var url = Uri.parse('http://172.21.241.49/learningplus/delete.php');
    var data = {};

    data['username'] = username;
    debugPrint('Delete: $username');
    var response = await http.post(
      url,
      body: data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      debugPrint('Print Result: $result');
      if (result == "Success") {
        debugPrint('Delete Success');
        getUsers();
      } else {
        Fluttertoast.showToast(
            msg: "Delete Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            // ignore: use_build_context_synchronously
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
      areButtonsVisible = false; // ปิดปุ่มเมื่อเปิดเมนู
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 211, 69),
        title: Row(
          children: [
            if (!isMenuOpen)
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');// เพิ่มโค้ดค้นหาที่คุณต้องการที่นี่
                },
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            if (!isMenuOpen)
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/lesson');
                  // เพิ่มโค้ดแจ้งเตือนที่คุณต้องการที่นี่
                },
                child: const Text(
                  'Lesson',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 255, 179),
                  ),
                ),
              ),
            if (!isMenuOpen)
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/about');
                  },
                child: const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 238, 218, 250),
              radius: 25,
              child: IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 30,
                  color: Color.fromARGB(255, 0, 192, 26),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(
                        user: users,
                        index: index,
                      ),
                    ),
                  ).then((result) {
                    if (result != null) {
                      // Handle the result if needed.
                      debugPrint(
                          'EditUser2 screen closed with result: $result');
                    }
                    debugPrint('Edit Clicked');
                    debugPrint(index.toString());
                  });
                },
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu, // ให้ icon เป็นเมนูเสมอ
            size: 35,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: () {
            toggleMenu(); // เปิดหรือปิดเมนู
          },
        ),
      ),
      
    );
  }
}