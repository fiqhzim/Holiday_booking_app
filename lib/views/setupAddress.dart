// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/SQLite/sqlite.dart';
import 'package:tour_package_booking/views/userInformation.dart';

class SetupAddress extends StatelessWidget {
  Users users;
  final List userInformation;
  SetupAddress({super.key, required this.userInformation, required this.users});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _line1 = TextEditingController();
  final TextEditingController _line2 = TextEditingController();
  final TextEditingController _postcode = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final db = DatabaseHelper();

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
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Image.asset(
                'assets/step2.jpg',
                height: size.height * 0.28,
                fit: BoxFit.contain,
              ),
              const Text(
                'Set up your Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              // const Text(
              //   'Complete your account setup by providing your proper biography info.',
              //   style: TextStyle(fontSize: 16, color: Color(0xff707070)),
              // ),
              // const SizedBox(height: 20),
              // const Text(
              //   'Name',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // ),
              const SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.streetAddress,
                controller: _line1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Line 1',
                  hintText: 'Enter the address',
                  // isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xff8A2BE2)),
                  ),
                  filled: true, //<-- SEE HERE
                  fillColor: const Color(0xffE6E6FF),
                ),
              ),
              const SizedBox(height: 15),
              // const Text(
              //   'Email',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // ),
              // const SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.streetAddress,
                controller: _line2,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // List<String> words = value.trim().split(RegExp(r'\s+'));
                    // if (words.length > 40) {
                    if (value.length > 40) {
                      return 'Input cannot be more than 40 words';
                    }
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  labelText: 'Line 2 (Optional)',
                  hintText: 'Enter the address Optional',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xff8A2BE2)),
                  ),
                  filled: true, //<-- SEE HERE
                  fillColor: const Color(0xffE6E6FF),
                ),
              ),
              const SizedBox(height: 15),
              // const Text(
              //   'Phone Number',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // ),
              // const SizedBox(height: 5),
              TextFormField(
                controller: _postcode,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your postcode!';
                  }
                  if (value.length != 5 ||
                      !RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please the correct postcode';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  hintText: 'Postcode',
                  labelText: 'Postcode',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xff8A2BE2)),
                  ),
                  filled: true, //<-- SEE HERE
                  fillColor: const Color(0xffE6E6FF),
                ),
              ),
              const SizedBox(height: 15),
              // const Text(
              //   'Phone Number',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // ),
              // const SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _city,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  hintText: 'City',
                  labelText: 'City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xff8A2BE2)),
                  ),
                  filled: true, //<-- SEE HERE
                  fillColor: const Color(0xffE6E6FF),
                ),
              ),
              const SizedBox(height: 15),
              // const Text(
              //   'Phone Number',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // ),
              // const SizedBox(height: 5),
              TextFormField(
                controller: _country,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  hintText: 'State',
                  labelText: 'State',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xff8A2BE2)),
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
                    // userInformation[0]['line1'] = _line1.text;
                    // userInformation[0]['line2'] = _line2.text;
                    // userInformation[0]['postcode'] = _postcode.text;
                    // userInformation[0]['city'] = _city.text;
                    // userInformation[0]['country'] = _country.text;

                    String address = '${_line1.text}, ${_line2.text}, ${_postcode.text}, ${_city.text}, ${_country.text}';

                      // print(userInformation[0]['name']);
                      // print(userInformation[0]['email_address']);
                      // print(userInformation[0]['phone_number']);
                      // print(address);
                      // print(users.userid);

                    db
                        .updateUsers(
                            userInformation[0]['name'], userInformation[0]['email_address'], userInformation[0]['phone_number'], address, users.userid)
                        .whenComplete(() async {
                           Users updatedUser = await db.getUser(users.userid);
                          // print(updatedUser.name);
                          // print(updatedUser.email);
                          // print(updatedUser.phone);
                          // print(updatedUser.address);
                          // print(updatedUser.userid);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserInformation(
                            userInformation: userInformation, users: updatedUser, canEdit: false, bookDate: const [],
                          ),
                        ),
                      );
                    });

                    // // print(userInformation);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => UserInformation(
                    //       userInformation: userInformation,
                    //     ),
                    //   ),
                    // );
                  }
                },
                child: const Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
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
