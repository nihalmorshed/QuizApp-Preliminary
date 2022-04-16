import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.teal,
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
                    color: Colors.teal,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: namecont,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Name!';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mailcont,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter your e-mail address!';
                  }
                  if (value!.length < 3) {
                    return 'Please enter atleast 3 characters!';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter E-mail',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                controller: passcont,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter password!';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
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
                  labelText: 'Confirm Password',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  if (frmkey.currentState!.validate()) {
                    print('Registration Successful!');
                  }
                },
                height: 50,
                minWidth: 100,
                color: Colors.teal,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
