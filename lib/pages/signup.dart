import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:learningplus/pages/Login.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  final List user;
  final int? index;
  const Signup({required this.user, this.index, Key? key}) : super(key: key);
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController bd_day = TextEditingController();
  TextEditingController bd_month = TextEditingController();
  TextEditingController bd_year = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phon_number = TextEditingController();
  int check = 0;

  Future addUser() async {
    var urlstr = 'http://172.21.241.49/learningplus/insert.php';
    var data = {};
    var url = Uri.parse(urlstr);
    data['username'] = username.text;
    data['password'] = password.text;
    data['name_first'] = firstname.text;
    data['name_last'] = lastname.text;
    data['bd_day'] = bd_day.text;
    data['bd_month'] = bd_month.text;
    data['bd_year'] = bd_year.text;
    data['email'] = email.text;
    data['phon_number'] = phon_number.text;
    // Add more fields as needed
    // $username = $_POST['username'];
    // $password = $_POST['password'];
    // $name_first = $_POST['name_first'];
    // $name_last = $_POST['name_last'];
    // $bd_day = $_POST['bd_day'];
    // $bd_month = $_POST['bd_month'];
    // $bd_year = $_POST['bd_year'];
    // $email = $_POST['email'];
    // $phon_number = $_POST['phon_number'];
    print(username.text);
    print(password.text);
    print(firstname.text);
    print(lastname.text);
    print(bd_day.text);
    print(bd_month.text);
    print(bd_year.text);
    print(email.text);
    print(phon_number.text);

    var response = await http.post(
      url,
      body: data,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data == "Error") {
        Fluttertoast.showToast(
            msg: "Username already exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        // Toast.show(
        //   "Username already exist",
        //   context,
        //   duration: Toast.LENGTH_SHORT,
        //   gravity: Toast.BOTTOM,
        // );
      } else if (data == "Success") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Insert Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        // Toast.show(
        //   "Insert Error",
        //   context,
        //   duration: Toast.LENGTH_SHORT,
        //   gravity: Toast.BOTTOM,
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the Login screen when the back button is pressed
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Register',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(
                  height: 10,
                ),
                Text('Register with your username',
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              // The validator receives the text that the user has entered.
                              controller: firstname,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'[a-zA-Z]')), // Allow only alphabetic characters
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Firstname',
                                hintText: 'Please input firstname',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter firstname';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ), // Space between first name and last name fields
                          Expanded(
                            child: TextFormField(
                              // The validator receives the text that the user has entered.
                              controller: lastname,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'[a-zA-Z]')), // Allow only alphabetic characters
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Lastname',
                                hintText: 'Please input lastname',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter lastname';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        controller: username,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          hintText: 'Please input username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        controller: password,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Please input password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              // The validator receives the text that the user has entered.
                              maxLength: 2,
                              controller: bd_day,
                              decoration: const InputDecoration(
                                labelText: 'DD',
                                hintText: 'Please input day',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter day';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10), // Space between first name and last name fields
                          Expanded(
                            child: TextFormField(
                              // The validator receives the text that the user has entered.
                              maxLength: 2,
                              controller: bd_month,
                              decoration: const InputDecoration(
                                labelText: 'MM',
                                hintText: 'Please input month',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter month';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              // The validator receives the text that the user has entered.
                              maxLength: 4,
                              controller: bd_year,
                              decoration: const InputDecoration(
                                labelText: 'YYYY',
                                hintText: 'Please input year',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter year';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: 'Email address',
                          hintText: 'Please input email address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email address';
                          }
                          // Regular expression to validate email addresses
                          final emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Invalid email address';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        maxLength: 10,
                        controller: phon_number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly // Allow only digits
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Phone number',
                          hintText: 'Please input Phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              addUser();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Text('Register'),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
