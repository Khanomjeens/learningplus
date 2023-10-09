import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learningplus/pages/adduser2.dart';
import 'package:learningplus/pages/edituser2.dart';
import 'package:learningplus/pages/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class About extends StatefulWidget {
  const About({super.key, required String username, required String password});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  List<Map<String, String>> persons = [
    {
      'name': 'Sutthawee Kongpiam',
      'email': '6340011015@psu.ac.th',
      'phone': '082-7066719',
      'image':
          'https://scontent.fbkk10-1.fna.fbcdn.net/v/t39.30808-6/383338542_1515542162514843_4661919526087944573_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=a2f6c7&_nc_eui2=AeEOWBpVPVBjq3sjrjmbfehcSB5zKnJsRrtIHnMqcmxGuwQNSEboORWMIM73wdAkTWiweWTtBxKPxT-6_Sc9tOpA&_nc_ohc=qVLlSnLhMlYAX_f4G3R&_nc_ht=scontent.fbkk10-1.fna&oh=00_AfDT29ml3S9AijinDnlRwCQ2pSFNVb6tQnFM9os-LGkY-w&oe=65278D03', // Add the image URL here
    },
    {
      'name': 'Nuttawut Pandum',
      'email': '6340011006@psu.ac.th',
      'phone': '093-1982554',
      'image':
          'https://scontent.fbkk10-1.fna.fbcdn.net/v/t1.6435-9/132204268_2843199892622177_2380329445321683997_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeG9pzA6m7VcsQV1fJAnFSjWX73C-0W5UNFfvcL7RblQ0Rwc4LsNRB2uDZrM37ubqsaXGEKdLGpmcSEb5RKA3cuG&_nc_ohc=XpVPlN4jvIUAX_hQN41&_nc_ht=scontent.fbkk10-1.fna&oh=00_AfD0kRSMNW7aHVC67ddoQw1WdT6mBCIsJNTPcD0s5U2RoQ&oe=654AFD3C', // Add the image URL here
    },
  ];

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
                    Navigator.pushNamed(context, '/home');
                    // เพิ่มโค้ดค้นหาที่คุณต้องการที่นี่
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
                      color: Color.fromARGB(255, 0, 255, 179),
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
        body: ListView.builder(
          itemCount: persons.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (index == 0)
                  Column(
                    children: [
                      const SizedBox(height: 25),
                      const Text(
                        'Developer Team',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 3, 97, 16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CircleAvatar(
                        backgroundImage: NetworkImage(persons[index]['image']!),
                        radius: 80,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${persons[index]['name']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color.fromARGB(255, 0, 192, 26),
                        ),
                      ),
                      Text(
                        'Email: ${persons[index]['email']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 73, 73, 73),
                        ),
                      ),
                      Text(
                        'Tel: ${persons[index]['phone']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 73, 73, 73),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Divider(
                        color: Color.fromARGB(169, 0, 192, 26),
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ],
                  ),
                if (index > 0)
                  ListTile(
                    title: Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(persons[index]['image']!),
                            radius: 80,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${persons[index]['name']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color.fromARGB(255, 0, 192, 26),
                            ),
                          ),
                          Text(
                            'Email: ${persons[index]['email']}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 73, 73, 73),
                            ),
                          ),
                          Text(
                            'Tel: ${persons[index]['phone']}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 73, 73, 73),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Divider(
                            color: Color.fromARGB(169, 0, 192, 26),
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ));
  }
}
