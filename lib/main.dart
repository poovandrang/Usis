import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/Auth_Provider.dart';
import 'Screens/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'Poovandran G',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Login(),
      ),
    );
  }
}
