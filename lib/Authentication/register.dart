import 'package:clean_dialog/clean_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tour_package_booking/JsonModels/users.dart';
import 'package:tour_package_booking/SQLite/sqlite.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //We will copy the previous textfield we designed to avoid time consuming
                  const ListTile(
                    title: Text(
                      "Register New Account",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //As we assigned our controller to the textformfields
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
                  //Confirm Password field
                  // Now we check whether password matches or not
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: confirmPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        } else if (password.text != confirmPassword.text) {
                          return "Passwords don't match";
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
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            //dialogbox alert
                            // await CustomAlertDialogBox.showCustomAlertBox(
                            //   context: context,
                            //   willDisplayWidget: Container(
                            //     decoration: BoxDecoration(
                            //       color:
                            //           Colors.blue, // Set the desired color here
                            //       borderRadius: BorderRadius.circular(
                            //           10), // Optional: add border radius
                            //     ),
                            //     padding: const EdgeInsets.all(16), // Optional: add padding
                            //     child: const Text(
                            //         'Congratulations! You have successfully created an account! We are pleased to welcome you to the family.', style: TextStyle(color: Colors.white), // Optional: change text color),
                            //   ),
                            //   )
                            // );

                            showDialog(
                              context: context,
                              builder: (context) => CleanDialog(
                                title: 'Success!',
                                content: 'You have successfully registered.',
                                backgroundColor:
                                    const Color.fromARGB(255, 16, 226, 97),
                                titleTextStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                contentTextStyle: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                                actions: [
                                  CleanDialogActionButtons(
                                      actionTitle: 'Accept',
                                      onPressed: () {
                                        //Login method will be here
                                        final db = DatabaseHelper();
                                        db
                                            .signup(Users(
                                                username: username.text,
                                                password: password.text))
                                            .whenComplete(() {
                                          //After success user creation go to login screen
                                          Navigator.pushNamed(
                                              context, '/loginPage');
                                        });
                                      }),
                                  CleanDialogActionButtons(
                                    actionTitle: 'Cancel',
                                    textColor: const Color(0XFF27ae61),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  //Sign up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            //Navigate to sign up
                            Navigator.pushNamed(context, '/loginPage');
                          },
                          child: const Text("Login"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
