// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/views/bookingDate.dart';

import '../tourPackage.dart';

class TourReviewPage extends StatefulWidget {
  final Users user;
  final TourPackage tourPackage;
  final List userInformation;
  const TourReviewPage(
      {super.key, required this.userInformation, required this.tourPackage, required this.user});

      

  @override
  State<TourReviewPage> createState() => _TourReviewPageState();
}

class _TourReviewPageState extends State<TourReviewPage> {
  double _currentRating = 0.0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      appBar: AppBar(
        title: const Text('Tour Package Reviews'),
        backgroundColor: const Color(0xffEAEAEA),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: <Widget>[
            const Text(
              'Share Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 30),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: const Offset(0, 3), // Offset (horizontal, vertical)
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Text(
                      'How was your experience?',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Your review will help us improve our product and make it user friendly for more users.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    RatingBar(
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.orange),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.orange,
                            ),
                            empty: const Icon(
                              Icons.star_outline,
                              color: Colors.orange,
                            )),
                        onRatingUpdate: (value) {
                          setState(() {
                            _currentRating = value;
                          });
                        }),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _reviewTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your feedback!';
                        }
                        return null;
                      },
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Share feedback...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xffEAEAEA),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              Review.reviews.add(
                                Review(
                                  rating: _currentRating,
                                  reviewText: _reviewTextController.text,
                                  userName: widget.user.username, package: '${widget.tourPackage.place ?? ''} - ${widget.tourPackage.country}',
                                ),
                              );
                              _reviewTextController.clear();
                              _currentRating = 3.0; // Reset rating
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8A2BE2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Submit Review',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 50,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       // Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDate(userInformation: widget.userInformation, users: widget.user)));
                    //       Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails(user: widget.user)));
                    //       // Navigator.pushNamed(context, '/userDetails');
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor: const Color(0xff8A2BE2),
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10))),
                    //     child: const Text(
                    //       'Review Your Booking',
                    //       style: TextStyle(color: Colors.white, fontSize: 16),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDate(userInformation: widget.userInformation, user: widget.user)));
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails(user: widget.user)));
                          // Navigator.pushNamed(context, '/userDetails');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8A2BE2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Home Page',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Text(
              'All Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            for (int i = 0; i < Review.reviews.length; i++)
              reviewCard(Review.reviews[i]),
          ],
        ),
      ),
    );
  }

  Container reviewCard(Review review) {
    String stringValue = review.rating.toString();
    List<String> parts = stringValue.split('.');
    int integerOne = int.parse(parts[0]); // The integer part
    int integerTwo = int.parse(parts[1]); // The fractional part
    int balance = 5 - review.rating.ceil();

    List<Widget> starIcons = [];
    for (int j = 1; j <= integerOne; j++) {
      starIcons.add(const Icon(Icons.star, color: Colors.amber));
    }
    if (integerTwo != 0) {
      starIcons.add(const Icon(Icons.star_half, color: Colors.amber));
    }
    for (int k = 1; k <= balance; k++) {
      starIcons.add(const Icon(Icons.star_border, color: Colors.amber));
    }

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 5, // Spread radius
            blurRadius: 7, // Blur radius
            offset: const Offset(0, 3), // Offset (horizontal, vertical)
          ),
        ],
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(5),
                  // width: 30,
                  // height: 30,
                  decoration: BoxDecoration(
                    // color: const Color(0xff9b59b6),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: const Color(0xff707070),
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xff707070),
                  )),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
              
                review.userName,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff222222)),
              )),
              Row(children: starIcons),
            ],
          ),
          const SizedBox(height: 15),
          Text('Package : ${review.package}'),
          const SizedBox(height: 15),
          Text(
            // 'loremf fasdfsf saf sf sf sf sa fa sfsfsafasfas fasfs fsf asfsfafsaf fsaf asf af  fasfsafsaf safaf asfasf',
            review.reviewText,
            textAlign: TextAlign.justify,
            style: const TextStyle(color: Color(0xff707070)),
          )
        ],
      ),
    );
  }
}
