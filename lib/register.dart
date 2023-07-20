import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRegister extends StatelessWidget {
  const MyRegister({super.key});

  @override
  Widget build(BuildContext context) {
    String email = '';
    String pass = '';
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/register.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                "SIGN UP",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    left: 35,
                    right: 35),
                child: Column(children: [
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      filled: true,
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    onChanged: ((value) => email = value),
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      filled: true,
                      hintText: "email id",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    onChanged: ((value) => pass = value),
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      filled: true,
                      hintText: "password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        // ignore: unused_local_variable
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: email, password: pass);
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, 'login');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          //display a snackbar
                          SnackBar snackBar = const SnackBar(
                            content: Text('The password provided is too weak.'),
                          );
                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          //print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          SnackBar snackBar = const SnackBar(
                            content: Text(
                                'The account already exists for that email.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // print('The account already exists for that email.');
                        }
                      } catch (e) {
                        //print(e);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    child: const Text('SIGN UP'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Already have an account?"),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    child: const Text('SIGN IN'),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
