// ignore_for_file: file_names, avoid_print
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tour_package_booking/JsonModels/tourbook.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/SQLite/sqlite.dart';
import 'package:tour_package_booking/tourPackage.dart';
import 'package:tour_package_booking/views/tourReviewPage.dart';

class DisplayTotalPayment extends StatelessWidget {
  final TourPackage tourPackage;
  final List userInformation;
  final Users user;
  final List selectedSeat;
  // final bool insurance;
  final List dataBook;
  final bool isApply;

  const DisplayTotalPayment({
    super.key,
    required this.tourPackage,
    required this.isApply,
    required this.userInformation,
    required this.selectedSeat,
    required this.dataBook,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      appBar: AppBar(
        title: const Text('Your Package'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            packageSelected(context),
            buttonPayment(context),
          ],
        ),
      ),
    );
  }

  SizedBox buttonPayment(context) {
    double price = isApply
        ? (double.parse(tourPackage.price!) * selectedSeat.length) * 0.9
        : double.parse(tourPackage.price!) * selectedSeat.length;

    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          final DateFormat inputFormatter =
              DateFormat('d MMMM yyyy'); // Example: 31 May 2024
          final DateFormat outputFormatter = DateFormat('d MMMM yyyy');
          final db = DatabaseHelper();

          try {
            DateTime bookDate = inputFormatter.parse(dataBook[0]['tour_date']);
            DateTime endDate = bookDate.add(const Duration(days: 5));
            String formattedEndDate = outputFormatter.format(endDate);

            db
                .bookPackage(TourBook(
                    userid: user.userid,
                    bookdate: dataBook[0]['book_date'],
                    booktime: dataBook[0]['book_time'],
                    tourstartdate:
                        // '${dataBook[0]['tour_date']} - ${dataBook[0]['tour_time']}',
                        '${dataBook[0]['tour_date']}',
                    // tourenddate: dataBook[0]['book_date'],
                    tourenddate: formattedEndDate,
                    tourpackage: tourPackage.place,
                    numpeople: selectedSeat.length,
                    packageprice: 'RM${(price * 0.05) + price}0'))
                .whenComplete(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TourReviewPage(
                            userInformation: userInformation,
                            tourPackage: tourPackage,
                            user: user,
                          )));
            });
            // print(formattedEndDate);
          } catch (e) {
            print('Error parsing date: $e');
          }

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => TourReviewPage(
          //               userInformation: userInformation,
          //               tourPackage: tourPackage,
          //             )));
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color(0xff8A2BE2),
        ),
        child: const Text(
          'Pay Now',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Container packageSelected(context) {
    double price = isApply
        ? (double.parse(tourPackage.price!) * selectedSeat.length) * 0.9
        : double.parse(tourPackage.price!) * selectedSeat.length;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    // 'assets/krabi-1.jpg',
                    tourPackage.image![0],
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${tourPackage.place}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${tourPackage.country}',
                      style: const TextStyle(
                          color: Color(0xff707070), fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Row(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.orange, size: 25),
                  Text(
                    '4.7',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Booking Details',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Column(
            children: <Widget>[
              rowDetails(context, 'Person', '${selectedSeat.length} Person'),
              rowDetails(context, 'Seat', selectedSeat.join(', ')),
              rowDetails(context, 'Insurance',
                  dataBook[0]['insurance'] ? 'YES' : 'NO'),
              rowDetails(context, 'Discount', isApply ? '10%' : '0%'),
              rowDetails(context, 'Price', 'RM${price}0'),
              rowDetails(context, 'Tax', '5%'),
              rowDetails(
                  context, 'Total Payment', 'RM${(price * 0.05) + price}0'),
            ],
          )
        ],
      ),
    );
  }

  Container rowDetails(context, title, data) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.check_box_rounded,
                size: 23,
                color: Colors.deepPurple,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              data.toString(),
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
