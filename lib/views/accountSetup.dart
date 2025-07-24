// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/views/bookingDate.dart';
import 'package:tour_package_booking/views/setupAddress.dart';

// ignore: must_be_immutable
class AccountSetup extends StatefulWidget {
  Users users;
  AccountSetup({super.key, required this.users});

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  // final db = DatabaseHelper();
  // late DatabaseHelper handler;
  // late Future<List<Users>> users;

  // @override
  // void initState() {
  //   handler = DatabaseHelper();
  //   users = handler.searchUser(widget.users.username);
  //   handler.initDB().whenComplete(() {
  //     users = getUser();
  //   });
  //   super.initState();
  // }

  // Future<List<Users>> getUser() {
  //   return handler.searchUser(widget.users.username);
  // }

  // //Refresh method
  // Future<void> _refresh() async {
  //   setState(() {
  //     users = getUser();
  //   });
  // }

  List userInformation = [];

  @override
  void initState() {
    // if (widget.users.address != null) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => BookingDate(
    //               userInformation: userInformation, users: widget.users)));
    // }
    super.initState();
    // Initialize the userInformation list with initial data
    userInformation = [
      {
        'name': _name.text,
        'email_address': _email.text,
        'phone_number': _phone.text
      }
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
    if (widget.users.address != null && widget.users.address!.isNotEmpty) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BookingDate(
            userInformation: userInformation,
            user: widget.users,
          ),
        ),
        (Route<dynamic> route) => false, // This removes all previous routes
      );
    }
  });
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  //Refresh method
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'assets/step1.jpg',
                height: size.height * 0.35,
                fit: BoxFit.contain,
              ),
              const Text(
                'Set up your account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              const Text(
                'Complete your account setup by providing your proper biography info.',
                style: TextStyle(fontSize: 16, color: Color(0xff707070)),
              ),
              const SizedBox(height: 20),
              const Text(
                'Full Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Username',
                  // isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true, //<-- SEE HERE
                  fillColor: const Color(0xffE6E6FF),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address!';
                  }
                  final RegExp emailRegex =
                      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  hintText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true, //<-- SEE HERE
                  fillColor: const Color(0xffE6E6FF),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Phone Number',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phone,
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
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true, //<-- SEE HERE
                  fillColor: const Color(0xffE6E6FF),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff8A2BE2),
                    // backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // userInformation.add({
                    //   'name': _name.text,
                    //   'email_address': _email.text,
                    //   'phone_number': _phone.text
                    // });
                    userInformation[0] = {
                      'name': _name.text,
                      'email_address': _email.text,
                      'phone_number': _phone.text
                    };

                    // db
                    //     .updateUsers(
                    //         _name.text, _email.text, _phone.text, '', widget.users.userid)
                    //     .whenComplete(() {
                    //       _refresh();
                    //       print(widget.users.email);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetupAddress(
                          userInformation: userInformation,
                          users: widget.users,
                        ),
                      ),
                    );
                    // });
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
