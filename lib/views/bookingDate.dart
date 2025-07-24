// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/views/homePage.dart';
import 'package:tour_package_booking/views/userDetails.dart';
import 'package:tour_package_booking/views/userInformation.dart';

class BookingDate extends StatefulWidget {
  final Users user;
  final List userInformation;
  const BookingDate(
      {super.key, required this.userInformation, required this.user});

  @override
  State<BookingDate> createState() => _BookingDateState();
}

class _BookingDateState extends State<BookingDate> {
  bool isCheck = false;
  final TextEditingController _bookDateController = TextEditingController();
  final TextEditingController _bookTimeController = TextEditingController();
  final TextEditingController _tourDateController = TextEditingController();
  final TextEditingController _tourTimeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime selectedTourDate = DateTime.now();

  List dataBook = [];

  @override
  void initState() {
    super.initState();
    // Initialize the userInformation list with initial data
    dataBook = [
      {
        'book_date': _bookDateController.text,
        'book_time': _bookTimeController.text,
        'tour_date': _tourDateController.text,
        'tour_time': _tourTimeController.text,
        'insurance': isCheck
      }
    ];
  }

  final _formKey = GlobalKey<FormState>();

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime now = DateTime.now();
    final DateTime firstDayOfNextMonth = DateTime(now.year, now.month + 1, 1);
    final DateTime lastDayOfNextMonth =
        DateTime(firstDayOfNextMonth.year, firstDayOfNextMonth.month + 12, 0);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: now,
      lastDate: lastDayOfNextMonth,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        final String formattedDate =
            "${picked.day} ${_getMonthName(picked.month)} ${picked.year}";
        controller.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                // color: Colors.purple.shade100,
                color: Colors.purple.shade100,
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/drawer_bg.jpg'),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/profile-1.jpg',
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.username,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.user.email ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigator.pop(context);
                widget.user.userid == 0
                    ? Navigator.pushNamed(context, '/registerPage')
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingDate(
                                userInformation: widget.userInformation,
                                user: widget.user)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                widget.user.userid == 0
                    ? Navigator.pushNamed(context, '/registerPage')
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserInformation(
                                  userInformation: widget.userInformation,
                                  users: widget.user,
                                  canEdit: true,
                                  bookDate: dataBook,
                                )));
              },
            ),
            ListTile(
              leading: const Icon(Icons.airplane_ticket),
              title: const Text('Your Booking'),
              onTap: () {
                widget.user.userid == 0
                    ? Navigator.pushNamed(context, '/registerPage')
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UserDetails(user: widget.user)));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text(widget.user.userid == 0 ? 'Register Now' : 'Logout'),
              onTap: () {
                widget.user.userid == 0
                    ? Navigator.pushNamed(context, '/registerPage')
                    : Navigator.pushNamedAndRemoveUntil(
                        context, '/loginPage', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: size.height * 0.45,
              decoration: const BoxDecoration(color: Colors.deepPurple),
              // decoration: BoxDecoration(
              //   color: Colors.purple.shade100,
              // ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Welcome,',
                            style: GoogleFonts.pacifico(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                          
                            // "${widget.userInformation[0]['username'] ?? ''}",
                            widget.user.username,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      // child: const Icon(Icons.person, size: 30,),
                      child: GestureDetector(
                        onTap: () {
                          widget.user.userid == 0
                              ? Navigator.pushNamed(context, '/registerPage')
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserInformation(
                                            userInformation:
                                                widget.userInformation,
                                            users: widget.user,
                                            canEdit: true,
                                            bookDate: dataBook,
                                          )));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: Image.asset('assets/profile-1.jpg'),
                          // child: const Icon(Icons.person),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height * 0.15),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Secure your',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'booking now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 5, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: const Offset(
                                  0, 3), // Offset (horizontal, vertical)
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode
                              .onUserInteraction, // the form fields will be automatically validated when the user interacts with them, and the error messages will disappear as soon as the user starts typing.
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Booking Date',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: size.width * 0.422,
                                      height: 60,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE6E6FF),
                                        borderRadius: BorderRadius.circular(5),
                                        // border: Border.all(
                                        //   color: const Color(0xff8A2BE2),
                                        // ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text('Date'),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _bookDateController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter book date';
                                                }
                                                return null;
                                              },
                                              readOnly: true,
                                              onTap: () => _selectDate(
                                                  context, _bookDateController),
                                              decoration: const InputDecoration(
                                                // contentPadding:
                                                //     EdgeInsets.symmetric(vertical: 5),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.422,
                                      height: 60,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE6E6FF),
                                        // border: Border.all(
                                        //   color: const Color(0xff8A2BE2),
                                        // ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text('Time'),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _bookTimeController,
                                              readOnly: true,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter book time';
                                                }
                                                return null;
                                              },
                                              // readOnly: true,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              onTap: () async {
                                                TimeOfDay? picked =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if (picked != null) {
                                                  String formattedTime =
                                                      _formatTime(picked);
                                                  _bookTimeController.text =
                                                      formattedTime;
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Text(
                                'Tour Date',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: size.width * 0.422,
                                      height: 60,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE6E6FF),
                                        borderRadius: BorderRadius.circular(5),
                                        // border: Border.all(
                                        //   color: const Color(0xff8A2BE2),
                                        // ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text('Date'),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _tourDateController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter tour date';
                                                }
                                                return null;
                                              },
                                              readOnly: true,
                                              onTap: () => _selectDate(
                                                  context, _tourDateController),
                                              decoration: const InputDecoration(
                                                // contentPadding:
                                                //     EdgeInsets.symmetric(vertical: 5),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.422,
                                      height: 60,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE6E6FF),
                                        // border: Border.all(
                                        //   color: const Color(0xff8A2BE2),
                                        // ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text('Time'),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _tourTimeController,
                                              readOnly: true,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter tour time';
                                                }
                                                return null;
                                              },
                                              // readOnly: true,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              onTap: () async {
                                                TimeOfDay? picked =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if (picked != null) {
                                                  String formattedTime =
                                                      _formatTime(picked);
                                                  _tourTimeController.text =
                                                      formattedTime;
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCheck = !isCheck;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: isCheck
                                              ? const Color(0xff8A2BE2)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: isCheck
                                            ? const Icon(
                                                Icons.check,
                                                size: 13,
                                                color: Colors.white,
                                              )
                                            : const Text(''),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Insurance included',
                                        style: TextStyle(
                                          color: isCheck
                                              ? Colors.black
                                              : const Color(0xff707070),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      // dataBook.add({
                                      //   'book_date': _bookDateController.text
                                      // });
                                      // dataBook.add({
                                      //   'book_time': _bookTimeController.text
                                      // });
                                      // dataBook.add({
                                      //   'tour_date': _tourDateController.text
                                      // });
                                      // dataBook.add({
                                      //   'tour_time': _tourTimeController.text
                                      // });
                                      // dataBook.add({'insurance': isCheck});

                                      dataBook[0] = {
                                        'book_date': _bookDateController.text,
                                        'book_time': _bookTimeController.text,
                                        'tour_date': _tourDateController.text,
                                        'tour_time': _tourTimeController.text,
                                        'insurance': isCheck
                                      };
                                      // print(SaveData.userInformation);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                    userInformation:
                                                        widget.userInformation,
                                                    dataBook: dataBook,
                                                    user: widget.user,
                                                    // insurance: isCheck,
                                                  )));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff8A2BE2),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  child: const Text(
                                    "Search",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay timeOfDay) {
    String period = timeOfDay.period == DayPeriod.am ? 'am' : 'pm';
    int hour = timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod;
    String minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute$period';
  }
}
