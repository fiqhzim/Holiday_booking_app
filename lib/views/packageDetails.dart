// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/views/selectSeat.dart';
import 'package:tour_package_booking/tourPackage.dart';

class PackageDetails extends StatefulWidget {
  final TourPackage tourPackage;
  final Users user;
  final List dataBook;
  final List userInformation;
  // final bool insurance;
  const PackageDetails(
      {super.key,
      required this.tourPackage,
      required this.userInformation,
      // required this.insurance,
      required this.user,
      required this.dataBook});

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  int currentIndexImage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffEAEAEA),
      body: Stack(
        children: <Widget>[
          // CarouselSlider(
          //   options: CarouselOptions(),
          //   items: tourPackage.image!
          //       .map((item) => Container(
          //             child: Center(child: Text(item.toString())),
          //             color: Colors.green,
          //           ))
          //       .toList(),
          // ),
          Image.asset(
            // 'assets/krabi.jpg',
            widget.tourPackage.image![currentIndexImage],

            height: size.height * 0.45,
            width: size.width,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              // 'Railay Beach',
                              '${widget.tourPackage.place}',
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${widget.tourPackage.country}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              '${widget.tourPackage.rating}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: size.width,
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'About',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${widget.tourPackage.about}',
                            style: const TextStyle(
                                fontSize: 16,
                                height: 1.8,
                                color: Color(0xff707070)),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Photos',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: widget.tourPackage.image!
                                    .asMap()
                                    .entries
                                    .map((image) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndexImage = image.key;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        image.value,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              );
                            }).toList()),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Package offered',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.tourPackage.packageOffered!
                                  .map((offered) {
                                final index = widget.tourPackage.packageOffered
                                    ?.indexOf(offered);
                                return Container(
                                  margin: (index == 0)
                                      ? const EdgeInsets.only(bottom: 10)
                                      : EdgeInsets.zero,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        (index == 0)
                                            ? Icons.access_time
                                            : Icons.hotel_class_outlined,
                                        size: 23,
                                        color: Colors.deepPurple,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        offered,
                                        style: const TextStyle(
                                          color: Color(0xff707070),
                                          // fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList()),
                          const SizedBox(height: 20),
                          const Text(
                            'Activities',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Text('• Kayaking'),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                // spacing: 10,
                                runSpacing: 10,
                                children: widget.tourPackage.activities!
                                    .map((activity) {
                                  return SizedBox(
                                    // color: Colors.amber,
                                    width: 160,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Icon(
                                          Icons.check_box_rounded,
                                          size: 23,
                                          color: Colors.deepPurple,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            activity,
                                            style: const TextStyle(
                                              color: Color(0xff707070),
                                              // fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList()),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'RM${widget.tourPackage.price}',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.deepPurple),
                              ),
                              const Text(
                                'per person',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xff707070)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60,
                            width: size.width * 0.45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                widget.user.userid == 0
                                    ? Navigator.pushNamed(
                                        context, '/registerPage')
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SelectSeat(
                                            tourPackage: widget.tourPackage,
                                            userInformation:
                                                widget.userInformation,
                                            dataBook: widget.dataBook, user: widget.user,
                                          ),
                                        ),
                                      );
                              },
                              child: const Text(
                                'Book Now',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
