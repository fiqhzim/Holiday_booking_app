// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/SQLite/sqlite.dart';
import 'package:tour_package_booking/views/userDetails.dart';
import 'package:tour_package_booking/views/userInformation.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  // late DatabaseHelper handler;
  final db = DatabaseHelper();

  // late Future<List<Users>> users;
  List<Users> userList = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    List<Map<String, dynamic>> users = await db.queryAllUsers();
    setState(() {
      userList = users.map((userMap) => Users.fromMap(userMap)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('User List'),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/loginPage', (Route<dynamic> route) => false);
              },
              child: const Icon(Icons.logout)),
          const SizedBox(width: 15),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              const Text(
                'Registered users',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    Users user = userList[index];
                    return userCard(user);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector userCard(users) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/userDetails');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserDetails(user: users)));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => UserDetails(
        //               // userid: response[2].userid,
        //               // users: users,
        //             )));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffEAEAEA),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Icon(Icons.person)),
            const SizedBox(width: 15),
            Expanded(
              
              child: Text(users.username),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserInformation(userInformation: [], users: users, canEdit: true, bookDate: [], isAdmin: true,)));
              },
              child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: const Center(
                      child: Text(
                    'user Details',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ))),
            ),
            const SizedBox(width: 10),
            // Icon(Icons.edit, size: 20,color: Colors.redAccent,),
            GestureDetector(
                onTap: () {
                  _showDeleteDialog(users.userid);
                },
                child: const Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.redAccent,
                )),

          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(int userid) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                db.deleteUser(userid).whenComplete(() {
                  _loadUsers();
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
