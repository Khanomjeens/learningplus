// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:learningplus/pages/edituser2.dart';
import 'package:learningplus/pages/login.dart';

class Profile extends StatelessWidget {
  final List<dynamic> user;
  final int index;

  const Profile({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 211, 69),
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255), // สีพื้นหลังที่คุณต้องการ
        child: ListView(
          //scrollDirection: Axis.horizontal,
          children: [
            ListTile(
              onTap: () {
                print('Data: ');
                print(user[index]);
              },
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'UserID : ${user[index]['user_id']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color.fromARGB(255, 0, 192, 26),
                  ),
                ),
              ),
            ),

            Center(
              child: InkWell(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 106, 224, 139),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            Container(
              margin: const EdgeInsets.all(8), // เพิ่มระยะห่างรอบกรอบ
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 247, 247, 247),
                borderRadius: BorderRadius.circular(8), // มุมมนสีมาวัน
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8), // เพิ่มระยะห่างรอบกรอบ
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 196, 239, 186), // สีเหลือง
                      borderRadius: BorderRadius.circular(8), // มุมมนสีมาวัน
                    ),
                    child: ListTile(
                      onTap: () {
                        print('Data: ');
                        print(user[index]);
                      },
                      title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Firstname : ${user[index]['name_first']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 87, 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8), // เพิ่มระยะห่างรอบกรอบ
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 196, 239, 186), // สีเหลือง
                      borderRadius: BorderRadius.circular(8), // มุมมนสีมาวัน
                    ),
                    child: ListTile(
                      onTap: () {
                        print('Data: ');
                        print(user[index]);
                      },
                      title: Align(
                        alignment: Alignment.center,
                        child: Text('Lastname : ${user[index]['name_last']}',style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 87, 12),
                          ),),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8), // เพิ่มระยะห่างรอบกรอบ
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 196, 239, 186), // สีเหลือง
                      borderRadius: BorderRadius.circular(8), // มุมมนสีมาวัน
                    ),
                    child: ListTile(
                      onTap: () {
                        print(user[0]);
                      },
                      title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Birthday : ${user[index]['bd_day']}/${user[index]['bd_month']}/${user[index]['bd_year']}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 87, 12),
                          ),),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8), // เพิ่มระยะห่างรอบกรอบ
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 196, 239, 186), // สีเหลือง
                      borderRadius: BorderRadius.circular(8), // มุมมนสีมาวัน
                    ),
                    child: ListTile(
                      onTap: () {
                        print(user[0]);
                      },
                      title: Align(
                        alignment: Alignment.center,
                        child: Text('Email : ${user[index]['email']}',style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 87, 12),
                          ),),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8), // เพิ่มระยะห่างรอบกรอบ
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 196, 239, 186), // สีเหลือง
                      borderRadius: BorderRadius.circular(8), // มุมมนสีมาวัน
                    ),
                    child: ListTile(
                      onTap: () {
                        print(user[index]);
                      },
                      title: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone),
                            SizedBox(
                                width: 8), // เพิ่มระยะห่างระหว่าง Icon และ Text
                            Text('${user[index]['phon_number']}',style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 87, 12),
                          ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUser2(
                        users: user,
                        index: index,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: const Text('Edit', style: TextStyle(fontSize: 16)),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(80, 30)), // กำหนดขนาดของปุ่มเล็กลง
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            // ปุ่ม Logout
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout Confirmation'),
                      content: Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: Text('Logout', style: TextStyle(fontSize: 16)),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Login(), // Navigate to your login screen
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16), // You can customize the text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
