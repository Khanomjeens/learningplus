import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learningplus/pages/adduser2.dart';
import 'package:learningplus/pages/edituser2.dart';
import 'package:learningplus/pages/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key, required String username, required String password});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  // เพิ่มโค้ดค้นหาที่คุณต้องการที่นี่
                },
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 255, 179),
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
                    color: Color.fromARGB(255, 255, 255, 255),
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
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            Center(
              child: InkWell(
                child: Container(
                  width: 450,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 106, 224, 139),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HOME',
                        style: TextStyle(
                          fontSize: 24, // ขนาดข้อความ
                          fontWeight: FontWeight.bold, // ตัวหนา
                          color: Colors.white, // สีข้อความ
                        ),
                      ),
                      Text(
                        'CHOSE',
                        style: TextStyle(
                          fontSize: 24, // ขนาดข้อความ
                          fontWeight: FontWeight.bold, // ตัวหนา
                          color: Colors.white, // สีข้อความ
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 40,
            ),

///////////////////////////////////////////////////////////////////////
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 205, 64, 64),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 196, 239, 186),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      onTap: () {
                        // ใส่โค้ดที่คุณต้องการให้ทำงานเมื่อคลิกที่ไอคอนทางด้านซ้าย
                      },
                      title: const Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 100,
                          ),
                          SizedBox(
                              width: 8), // เพิ่มระยะห่างระหว่างไอคอนและข้อความ
                          Text(
                            'Your Text Here', // แทนด้วยข้อความที่คุณต้องการใช้
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // แทนด้วยสีของข้อความ
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 205, 64, 64),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 196, 239, 186),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      onTap: () {
                        // ใส่โค้ดที่คุณต้องการให้ทำงานเมื่อคลิกที่ไอคอนทางด้านซ้าย
                      },
                      title: const Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 100,
                          ),
                          SizedBox(
                              width: 8), // เพิ่มระยะห่างระหว่างไอคอนและข้อความ
                          Text(
                            'Your Text Here', // แทนด้วยข้อความที่คุณต้องการใช้
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // แทนด้วยสีของข้อความ
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 205, 64, 64),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 196, 239, 186),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      onTap: () {
                        // ใส่โค้ดที่คุณต้องการให้ทำงานเมื่อคลิกที่ไอคอนทางด้านซ้าย
                      },
                      title: const Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 100,
                          ),
                          SizedBox(
                              width: 8), // เพิ่มระยะห่างระหว่างไอคอนและข้อความ
                          Text(
                            'Your Text Here', // แทนด้วยข้อความที่คุณต้องการใช้
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // แทนด้วยสีของข้อความ
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 205, 64, 64),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 196, 239, 186),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      onTap: () {
                        // ใส่โค้ดที่คุณต้องการให้ทำงานเมื่อคลิกที่ไอคอนทางด้านซ้าย
                      },
                      title: const Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 100,
                          ),
                          SizedBox(
                              width: 8), // เพิ่มระยะห่างระหว่างไอคอนและข้อความ
                          Text(
                            'Your Text Here', // แทนด้วยข้อความที่คุณต้องการใช้
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // แทนด้วยสีของข้อความ
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 205, 64, 64),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 196, 239, 186),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      onTap: () {
                        // ใส่โค้ดที่คุณต้องการให้ทำงานเมื่อคลิกที่ไอคอนทางด้านซ้าย
                      },
                      title: const Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 100,
                          ),
                          SizedBox(
                              width: 8), // เพิ่มระยะห่างระหว่างไอคอนและข้อความ
                          Text(
                            'Your Text Here', // แทนด้วยข้อความที่คุณต้องการใช้
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // แทนด้วยสีของข้อความ
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
////////////////////////////////////////////////////////////////////////
          ],
        ),
      ),
    );
  }
}
