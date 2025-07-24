// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/views/bookingDate.dart';
import 'package:tour_package_booking/views/packageDetails.dart';
import 'package:tour_package_booking/views/userDetails.dart';
import 'package:tour_package_booking/views/userInformation.dart';
// import 'package:tour_package_booking/views/userInformation.dart';
import '../tourPackage.dart';

class HomePage extends StatefulWidget {
  final List userInformation;
  final Users user;
  // final bool insurance;
  final List dataBook;
  // const HomePage({super.key, required this.userInformation, required this.insurance});
  const HomePage(
      {super.key,
      required this.userInformation,
      required this.dataBook,
      required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                                  bookDate: widget.dataBook,
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
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                header(),
                SizedBox(height: size.height * 0.03),
                topPackage(context, size, TourPackage.tourPackage),
                newPackage(context, size, TourPackage.tourPackage),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container newPackage(context, Size size, List<TourPackage> tourPackage) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('New this year', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          Column(
              children: tourPackage.map((tour) {
            return newCard(size, context, tour);
          }).toList())
        ],
      ),
    );
  }

  Widget newCard(Size size, context, tourPackage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PackageDetails(
              tourPackage: tourPackage,
              // userInformation: widget.userInformation, insurance: widget.dataBook[0]['insurance'], user: widget.user,
              userInformation: widget.userInformation, user: widget.user,
              dataBook: widget.dataBook,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  // 'assets/krabi.jpg',
                  tourPackage.image[0],
                  width: size.width * 0.26,
                  height: 80,
                  fit: BoxFit.cover,
                )),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tourPackage.place,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${tourPackage.activities[0]}, ${tourPackage.activities[1]}',
                    style: const TextStyle(
                      color: Color(0xff707070),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Tour length | ${tourPackage.packageOffered[0]}',
                    // Text('Tour length | ',
                    style: const TextStyle(
                      color: Color(0xff707070),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 23,
                ),
                const SizedBox(width: 5),
                Text(
                  tourPackage.rating.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(width: 5),
            // const Text('RM1,500', style: TextStyle(color: Colors.blue),)
          ],
        ),
      ),
    );
  }

  Widget topPackage(context, Size size, List<TourPackage> tourPackage) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tourPackage.map((tour) {
          return topCard(context, size, tour);
        }).toList(),
      ),
    );
  }

  Widget topCard(context, Size size, tourPackage) {
    return GestureDetector(
      onTap: () {
        widget.user.userid == 0
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PackageDetails(
                    tourPackage: tourPackage,
                    // userInformation: [], insurance: false, user: widget.user,
                    userInformation: const [], user: widget.user,
                    dataBook: const [],
                  ),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PackageDetails(
                    tourPackage: tourPackage,
                    // userInformation: widget.userInformation, insurance: widget.dataBook[0]['insurance'], user: widget.user,
                    userInformation: widget.userInformation, user: widget.user,
                    dataBook: widget.dataBook,
                  ),
                ),
              );
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            width: size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    tourPackage.image[0],
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tourPackage.place,
                        style: const TextStyle(fontSize: 23),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.location_on,
                            color: Color(0xff707070),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            tourPackage.country,
                            style: const TextStyle(
                                color: Color(0xff707070), fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 70,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 25,
                  ),
                  Text(
                    tourPackage.rating.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const Icon(Icons.menu),
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
                  style: GoogleFonts.pacifico(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  
                  // "${widget.userInformation[0]['username'] ?? ''}",
                  widget.user.username,
                  style: const TextStyle(fontSize: 20),
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
                                  userInformation: widget.userInformation,
                                  users: widget.user,
                                  canEdit: true,
                                  bookDate: widget.dataBook,
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
    );
  }
}
