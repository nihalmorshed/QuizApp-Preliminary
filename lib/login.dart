import 'package:flutter/material.dart';
import './register.dart';

class loginregister extends StatefulWidget {
  loginregister({Key? key}) : super(key: key);

  @override
  State<loginregister> createState() => _loginregisterState();
}

class _loginregisterState extends State<loginregister> {
  TextEditingController mailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  GlobalKey<FormState> frmkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Start Quiz"),
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
                      color: Colors.teal,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: mailcont,
                  decoration: InputDecoration(
                    labelText: 'Enter E-mail',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passcont,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 50,
                  minWidth: 100,
                  color: Colors.teal,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                OutlineButton(
                  child: Text('Register'),
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
    );
  }
}
