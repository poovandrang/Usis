import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Provider/Auth_Provider.dart';
import 'Home.dart';
import 'Registation.dart';

class Login extends StatelessWidget {
  final TextEditingController User = TextEditingController();
  final TextEditingController Pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
              height: 30,
            ),
            TextField(
              controller: Pass,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6))),
              obscureText: true,
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                if (User.text.isEmpty || Pass.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "All fields are required.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                  return;
                }
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                final success = await authProvider.login(
                  User.text,
                  Pass.text,
                );
                if (success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid username or password')),
                  );
                }
              },
              child: Text('LOGIN', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, elevation: 8),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registration()),
                );
              },
              child: Text(
                'REGISTER',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
