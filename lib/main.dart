import 'package:flutter/material.dart';
import 'package:my_api/upload_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application Programming Interface",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UploadImageScreen(),
    );
  }
}
