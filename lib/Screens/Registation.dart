import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Helper/Db_helper.dart';
import '../Provider/Auth_Provider.dart';

class Registration extends StatelessWidget {
  final TextEditingController User = TextEditingController();
  final TextEditingController Pass = TextEditingController();
  final TextEditingController Mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'REGISTER',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: User,
              decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: Pass,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6))),
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: Mobile,
              maxLength: 10,
              decoration: InputDecoration(
                  labelText: 'Mobile',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6))),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (User.text.isEmpty ||
                    Pass.text.isEmpty ||
                    Mobile.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "All fields are required.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                  return;
                }

                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                final usernameExists =
                    await DatabaseHelper().checkUsernameExists(User.text);

                if (usernameExists) {
                  Fluttertoast.showToast(
                    msg:
                        "Username already exists. Please choose a different username.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                } else {
                  await authProvider.register(
                    User.text,
                    Pass.text,
                    Mobile.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Register',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, elevation: 8),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
