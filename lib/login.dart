import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/errorlogin.dart';
import './register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './home.dart';
import './usermodel.dart';

class loginregister extends StatefulWidget {
  loginregister({Key? key}) : super(key: key);

  @override
  State<loginregister> createState() => _loginregisterState();
}

class _loginregisterState extends State<loginregister> {
  GlobalKey<FormState> frmkey = GlobalKey<FormState>();
  TextEditingController mailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  TextEditingController namecont = TextEditingController();

  loginuser(BuildContext context) async {
    try {
      UserCredential uc = await auth.signInWithEmailAndPassword(
          email: mailcont.text, password: passcont.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homescreen()),
      );
    } on Exception {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => error()),
      );
    }
  }

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: Text(
            "Log-in to Enter",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
            child: Form(
              key: frmkey,
              child: ListView(
                children: [
                  Text(
                    'Log-in',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    cursorColor: Colors.orange,
                    style: TextStyle(color: Colors.orange),
                    controller: namecont,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your name!';
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'Enter Name',
                      labelStyle: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    cursorColor: Colors.orange,
                    style: TextStyle(color: Colors.orange),
                    controller: mailcont,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your e-mail address!';
                      }
                      if (value.length < 3) {
                        return 'Please enter atleast 3 characters!';
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'Enter E-mail',
                      labelStyle: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    cursorColor: Colors.orange,
                    style: TextStyle(color: Colors.orange),
                    controller: passcont,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter password!';
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'Enter Password',
                      labelStyle: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (frmkey.currentState!.validate()) {
                        var firebaseUser = FirebaseAuth.instance.currentUser;
                        firestoreInstance
                            .collection("users")
                            .doc(firebaseUser?.uid)
                            .set({
                          "name": namecont.text,
                          "email": mailcont.text,
                          "uid": firebaseUser?.uid,
                        }, SetOptions(merge: true)).then((_) {
                          print("success!");
                        });
                        loginuser(context);
                        print('Validation Successful!');
                      }
                    },
                    height: 50,
                    minWidth: 100,
                    color: Colors.orange,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlineButton(
                    borderSide: BorderSide(color: Colors.orange),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => register()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
