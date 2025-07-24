import 'package:flutter/material.dart';
import 'package:tour_package_booking/Authentication/login.dart';
import 'package:tour_package_booking/Authentication/register.dart';
import 'package:tour_package_booking/views/userList.dart';

// import 'views/accountSetup.dart';
import 'views/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tour Package Booking',
      routes: {
        '/': (context) => const SplashScreen(),
        // '/accountSetup': (context) => AccountSetup(),
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
        '/userList': (context) => const UserList(),
      },
    );
  }
}
