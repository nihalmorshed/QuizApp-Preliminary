import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController mailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  TextEditingController namecont = TextEditingController();
  GlobalKey<FormState> frmkey = GlobalKey<FormState>();

  registeruser(BuildContext context) async {
    await auth.createUserWithEmailAndPassword(
        email: mailcont.text, password: passcont.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
        child: Form(
          key: frmkey,
          child: ListView(
            children: [
              Text(
                'Registration',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.orange),
                cursorColor: Colors.orange,
                controller: namecont,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Name!';
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
                style: TextStyle(color: Colors.orange),
                cursorColor: Colors.orange,
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
                style: TextStyle(color: Colors.orange),
                cursorColor: Colors.orange,
                obscureText: true,
                controller: passcont,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter password!';
                  }
                  if (value.length < 6) {
                    return 'Password should be at least 6 characters!';
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
              TextFormField(
                style: TextStyle(color: Colors.orange),
                cursorColor: Colors.orange,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm Password!';
                  }
                  if (value != passcont.text) {
                    return 'Password doesn\'t match!';
                  }
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelText: 'Confirm Password',
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
                    registeruser(context);
                    print('Registration Successful!');
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
            ],
          ),
        ),
      ),
    );
  }
}
