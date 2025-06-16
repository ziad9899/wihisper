import 'package:flutter/material.dart';
import 'screen/home_screen.dart'; // ✅ تعديل المسار الصحيح

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whisper',
      theme: ThemeData(
        fontFamily: 'Tajawal',
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(), // ✅ سيتم التعرف عليها الآن
    );
  }
}
