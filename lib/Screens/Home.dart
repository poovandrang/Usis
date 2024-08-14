import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/Auth_Provider.dart';
import 'Login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOME',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Login()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Icon(
            Icons.home,
            color: Colors.blueAccent,
            size: 300,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
