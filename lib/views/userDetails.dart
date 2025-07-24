import 'package:flutter/material.dart';
import 'package:tour_package_booking/JsonModels/tourbook.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/SQLite/sqlite.dart';

class UserDetails extends StatefulWidget {
  final Users user;
  const UserDetails({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late DatabaseHelper handler;

  bool canEdit = false;

  final db = DatabaseHelper();

  final formKey = GlobalKey<FormState>();

  List<TextEditingController> tourpackageControllers = [];
  List<TextEditingController> bookdateControllers = [];
  List<TextEditingController> booktimeControllers = [];
  List<TextEditingController> tourstartdateControllers = [];
  List<TextEditingController> tourenddateControllers = [];
  List<TextEditingController> numpeopleControllers = [];
  List<TextEditingController> packagepriceControllers = [];

  List<TourBook> userPackage = [];
  bool isLoading = true;

  bool _validateAndSave(int index) {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    handler = DatabaseHelper();
    loadUserPackage();
  }

  Future<void> loadUserPackage() async {
    await handler.initDB();
    List<TourBook> fetchedTourBooks =
        await handler.getUserPackage(widget.user.userid);
    setState(() {
      userPackage = fetchedTourBooks;
      initializeControllers();
      isLoading = false;
    });
  }

  void initializeControllers() {
    tourpackageControllers = List.generate(userPackage.length,
        (index) => TextEditingController(text: userPackage[index].tourpackage));
    bookdateControllers = List.generate(userPackage.length,
        (index) => TextEditingController(text: userPackage[index].bookdate));
    booktimeControllers = List.generate(userPackage.length,
        (index) => TextEditingController(text: userPackage[index].booktime));
    tourstartdateControllers = List.generate(
        userPackage.length,
        (index) =>
            TextEditingController(text: userPackage[index].tourstartdate));
    tourenddateControllers = List.generate(userPackage.length,
        (index) => TextEditingController(text: userPackage[index].tourenddate));
    numpeopleControllers = List.generate(
        userPackage.length,
        (index) =>
            TextEditingController(text: '${userPackage[index].numpeople}'));
    packagepriceControllers = List.generate(
        userPackage.length,
        (index) =>
            TextEditingController(text: userPackage[index].packageprice));
  }

  void _showDeleteDialog(int bookId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this package?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                db.deleteUserPackage(bookId).whenComplete(() {
                  loadUserPackage();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      appBar: AppBar(
        title: const Text('User Package'),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  shrinkWrap: true,
                  itemCount: userPackage.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  image(userPackage[index].tourpackage),
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  enabled: canEdit,
                                  textAlign: TextAlign.start,
                                  controller: tourpackageControllers[index],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter tour package';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              !canEdit
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          canEdit = !canEdit;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        if (_validateAndSave(index)) {
                                          db
                                              .updateUserPackage(
                                            bookdateControllers[index].text,
                                            booktimeControllers[index].text,
                                            tourstartdateControllers[index]
                                                .text,
                                            tourenddateControllers[index].text,
                                            tourpackageControllers[index].text,
                                            numpeopleControllers[index].text,
                                            packagepriceControllers[index].text,
                                            userPackage[index].bookid,
                                          )
                                              .whenComplete(() {
                                            loadUserPackage();
                                          });
                                          setState(() {
                                            canEdit = !canEdit;
                                          });
                                        }
                                      },
                                      child: const Icon(
                                        Icons.save,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                    ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  _showDeleteDialog(userPackage[index].bookid!);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _buildTextRow(
                              'Book Date : ', bookdateControllers[index]),
                          const SizedBox(height: 10),
                          _buildTextRow(
                              'Book Time : ', booktimeControllers[index]),
                          const SizedBox(height: 10),
                          _buildTextRow('Tour Start Date : ',
                              tourstartdateControllers[index]),
                          const SizedBox(height: 10),
                          _buildTextRow('Tour End Date : ',
                              tourenddateControllers[index]),
                          const SizedBox(height: 10),
                          _buildTextRow('Number of people : ',
                              numpeopleControllers[index],
                              format: true),
                          const SizedBox(height: 10),
                          _buildTextRow('Package Price : ',
                              packagepriceControllers[index]),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildTextRow(String label, TextEditingController controller,
      {bool format = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 200,
          child: format && !canEdit
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 12.5),
                  child: Text(
                    '${controller.text} Person',
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Color(0xff999999)),
                  ),
                )
              : TextFormField(
                  enabled: canEdit,
                  textAlign: TextAlign.end,
                  controller: controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter $label';
                    }
                    return null;
                  },
                ),
        ),
      ],
    );
  }

  String image(String? image) {
    switch (image) {
      case 'Raylay Beach':
        return 'assets/krabi-1.jpg';
      case 'Manhattan':
        return 'assets/new-york-1.jpg';
      case 'Eiffel Tower':
        return 'assets/paris-1.jpeg';
      case 'Palace Tour':
        return 'assets/seoul-1.jpeg';
      default:
        return 'assets/swiss-1.jpeg';
    }
  }

  // Widget Container() {
  //   return Column(children: <Widget>[
  //     Row(children: <Widget>[
  //       Container())
  //     ],)
  //   ],);
  // }
}
