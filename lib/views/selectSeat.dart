// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/views/displayTotalPayment.dart';
import '../tourPackage.dart';

class SelectSeat extends StatefulWidget {
  final Users user;
  final TourPackage tourPackage;
  final List userInformation;
  // final bool insurance;
  final List dataBook;
  const SelectSeat({
    super.key,
    required this.tourPackage,
    required this.userInformation,
    required this.dataBook, required this.user,
  });

  @override
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  final _formKey = GlobalKey<FormState>();

  List selectedSeat = [];
  List<String> seatA = ['A1', 'A2', 'A3', 'A4', 'A5'];
  List<String> seatB = ['B1', 'B2', 'B3', 'B4', 'B5'];
  List<String> seatC = ['C1', 'C2', 'C3', 'C4', 'C5'];
  List<String> seatD = ['D1', 'D2', 'D3', 'D4', 'D5'];

  String codeDiscount = 'AFIQTHEGREAT';
  bool canApply = true;

  double totalPay = 0;
  final TextEditingController _discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 25),
                  width: size.width * 0.5,
                  child: const Text(
                    'Select Your Flight Seat',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
                // SEAT INFO
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                color: const Color(0xffE6E6FF),
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: const Color(0xff8A2BE2))),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Available',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                color: const Color(0xff8A2BE2),
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: const Color(0xff8A2BE2))),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Selected',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Unavailable',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // CHOOSE SEAT
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 30, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          section(size, 'A', seatA),
                          SizedBox(width: size.width * 0.03),
                          section(size, 'B', seatB),
                          middle(size),
                          section(size, 'C', seatC),
                          SizedBox(width: size.width * 0.03),
                          section(size, 'D', seatD),
                        ],
                      ),
                      // ADD DISCOUNT CODE
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Form(
                          key: _formKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  controller: _discountController,
                                  enabled: canApply,
                                  // validator: (value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the discount code!';
                                    }
                                    if (value != codeDiscount) {
                                      return 'Invalid Code';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Apply Discount Code',
                                    filled: true, //<-- SEE HERE
                                    fillColor: const Color(0xffE6E6FF),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xff8A2BE2)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xff8A2BE2)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    contentPadding: const EdgeInsets.all(15),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_formKey.currentState!.validate()) {
                                        if (canApply == true &&
                                            _discountController.text ==
                                                codeDiscount) {
                                          totalPay = totalPay * 0.9;
                                          canApply = false;
                                        }
                                      }
                                      // print(_discountController.text == codeDiscount);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: const Color(0xff8A2BE2),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      'Apply',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // CALCULATE
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  'Your Seat:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff707070),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    selectedSeat.join(', '),
                                    // 'C1, C2, C3, C4, C5, D1, D2, D3, D4, D5, A1, A2, A3, A4, A5, B1, B2, B3, B4, B5',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  'Total:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff707070),
                                  ),
                                ),
                                Text(
                                  'RM${totalPay}0',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // CHECKOUT BUTTON
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedSeat.isEmpty) {
                        _showSeatSelectionDialog(context);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DisplayTotalPayment(
                                      tourPackage: widget.tourPackage,
                                      isApply: !canApply,
                                      userInformation: widget.userInformation,
                                      selectedSeat: selectedSeat,
                                      dataBook: widget.dataBook, user: widget.user,
                                    )));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xff8A2BE2)),
                    child: const Text(
                      'Continue to Checkout',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSeatSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Attention'),
          content: const Text(
              'Please select your seat before proceeding to checkout.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Column section(Size size, title, List<dynamic> seat) {
    return Column(
      children: <Widget>[
        Text(title,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xff707070),
            )),
        const SizedBox(height: 20),
        Column(
            children: seat
                .map((item) => GestureDetector(
                      onTap: () {
                        setState(() {
                          // isChecked = !isChecked;
                          selectedSeat.contains(item)
                              ? selectedSeat.remove(item)
                              : selectedSeat.add(item);
                          selectedSeat.sort();

                          totalPay =
                              double.parse(widget.tourPackage.price ?? '0') *
                                  selectedSeat.length;

                          totalPay = canApply ? totalPay : totalPay * 0.9;
                        });
                      },
                      child: Container(
                          width: size.width * 0.13,
                          height: size.width * 0.13,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: selectedSeat.contains(item)
                                ? const Color(0xff8A2BE2)
                                : const Color(0xffE6E6FF),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xff8A2BE2),
                            ),
                          ),
                          child: selectedSeat.contains(item)
                              ? const Center(
                                  child: Text(
                                    'YOU',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              : const Text('')),
                    ))
                .toList()),
      ],
    );
  }

  Column middle(Size size) {
    return Column(
      children: <Widget>[
        for (int i = 0; i <= seatB.length; i++)
          Container(
            width: size.width * 0.13,
            height: size.width * 0.13,
            margin: const EdgeInsets.only(bottom: 15),
            child: Center(
              child: Text(
                i == 0 ? '' : '$i',
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff707070),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
