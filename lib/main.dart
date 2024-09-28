import 'package:flutter/material.dart';

import 'login_screen.dart';


void main() {
  runApp(const Assessment());
}

class Assessment extends StatelessWidget {
  const Assessment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}



