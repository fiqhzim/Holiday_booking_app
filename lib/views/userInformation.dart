// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/SQLite/sqlite.dart';
import 'package:tour_package_booking/views/bookingDate.dart';
import 'package:tour_package_booking/views/userList.dart';
// import 'package:tour_package_booking/views/homePage.dart';

// ignore: must_be_immutable
class UserInformation extends StatefulWidget {
  Users users;
  List bookDate;
  final List userInformation;
  bool canEdit = false;
  bool? isAdmin;
  UserInformation(
      {super.key,
      required this.userInformation,
      required this.users,
      required this.canEdit,
      required this.bookDate, this.isAdmin});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final db = DatabaseHelper();
  late DatabaseHelper handler;
  late Future<List<Users>> users;

  // @override
  // void initState() {
  //   handler = DatabaseHelper();
  //   users = handler.getUser(users.username);
  //   handler.initDB().whenComplete(() {
  //     users = getUser();
  //   });
  //   super.initState();
  // }

  // Future<List<Users>> getUser() {
  //   return handler.getUser(widget.users.username);
  // }
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    handler.initDB().whenComplete(() async {
      await db.getUser(widget.users.userid);
    });
    super.initState();
    name.text = widget.users.name!;
    email.text = widget.users.email!;
    phone.text = "0${widget.users.phone}";
    address.text = widget.users.address!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Please check your details')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 20, vertical: size.height * 0.1),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Full Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    enabled: widget.canEdit,
                    // initialValue: "${userInformation[0]['username']}",
                    // initialValue: "${widget.users.name}",
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "email_address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    enabled: widget.canEdit,
                    // initialValue: "${userInformation[0]['email_address']}",
                    // initialValue: "${widget.users.email}",
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address!';
                      }
                      final RegExp emailRegex = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "phone_number",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    enabled: widget.canEdit,
                    // initialValue: "${userInformation[0]['phone_number']}",
                    // initialValue: "${widget.users.phone}",
                    controller: phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number!';
                      }
                      if (value.length > 11 ||
                          value.length < 10 ||
                          !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please the correct phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    enabled: widget.canEdit,
                    maxLines: null,
                    // initialValue:
                    // "${userInformation[0]['line1']}, ${userInformation[0]['line2'].isEmpty ? '' : userInformation[0]['line2'] + ','} ${userInformation[0]['postcode']}, ${userInformation[0]['city']}, ${userInformation[0]['country']}",
                    // "${widget.users.address}",
                    controller: address,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color(0xff8A2BE2)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.canEdit == true
                              ? db
                                  .updateUsers(
                                      name.text,
                                      email.text,
                                      phone.text,
                                      address.text,
                                      widget.users.userid)
                                  .whenComplete(() async {
                                  Users updatedUser =
                                      await db.getUser(widget.users.userid);

                                      // ignore: use_build_context_synchronously
                                      widget.isAdmin == true ? Navigator.push(context, MaterialPageRoute(builder: (context) => UserList())) :

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => HomePage(
                                  //       userInformation: widget.userInformation,
                                  //       dataBook: [],
                                  //       user: updatedUser,
                                  //     ),
                                  //   ),
                                  // );
                                  // Navigator.pop(context, updatedUser);
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingDate(
                                            userInformation:
                                                widget.userInformation,
                                            user: updatedUser,
                                          )));
                                })
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingDate(
                                            userInformation:
                                                widget.userInformation,
                                            user: widget.users,
                                          )));
                        }
                      },
                      child: Text(
                        widget.canEdit == true ? 'Update' : 'Start Booking',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
