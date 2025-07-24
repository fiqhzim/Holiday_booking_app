import 'package:flutter/material.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/SQLite/sqlite.dart';
import 'package:tour_package_booking/views/accountSetup.dart';
import 'package:tour_package_booking/views/homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //A bool variable for show and hide password
  bool isVisible = false;
  //Here is our bool variable
  bool isLoginTrue = false;

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  final db = DatabaseHelper();

  Users defaultUser = Users(
      userid: 0,
      username: 'guest',
      name: 'Guest',
      email: '',
      phone: 0,
      address: '',
      password: '');

  login() async {
    var response =
        await db.login(Users(username: username.text, password: password.text));
    if (response[0] == true) {
      // print('berjaya daftar');
      //If login is correct, then go to notes
      if (!mounted) return;

      if (response[1] == 'admin') {
        Navigator.pushNamed(context, '/userList');
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => UserList(
        //               // userid: response[2].userid,
        //               users: response[2],
        //             )));
      } else {
        // print(response[2].userid);
        // Navigator.pushNamedAndRemoveUntil(context, '/accountSetup', (route) => false);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AccountSetup(
                      // userid: response[2].userid,
                      users: response[2],
                    )));
      }
    } else {
      //If not, true the bool value to show error message
      setState(() {
        isLoginTrue = true;
      });
      // print('username dan password belum didaftarkan');
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 60),
                //Username field
                //Before we show the image, after we copied the image we need to define the location in pubspec.yaml
                Image.asset("assets/login.jpg",
                    // width: 280,
                    height: 300),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(.2)),
                  child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "username is required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: "Username",
                    ),
                  ),
                ),
                //Password field
                Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(.2)),
                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      }
                      return null;
                    },
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              //In here we will create a click to show and hide the password a toggle button
                              setState(() {
                                //toggle button
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(isVisible
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),
                ),
                const SizedBox(height: 10),
                //Login button
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple),
                  child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          //Login method will be here
                          login();
                          //Now we have a response from our sqlite method
                          //We are going to create a user
                        }
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                //Sign up button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          //Navigate to sign up
                          Navigator.pushNamed(context, '/registerPage');
                        },
                        child: const Text("SIGN UP"))
                  ],
                ),
                // We will disable this message in default, when user and pass is incorrect we will trigger this message to user
                isLoginTrue
                    ? const Text(
                        "Username or password is incorrect",
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                  userInformation: const [],
                                  dataBook: const [],
                                  user: defaultUser)));
                    },
                    child: const Text('View Package'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
