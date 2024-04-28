import 'package:contact_app/my_app/setup.dart';
import 'package:contact_app/pages/contact_page.dart';
import 'package:contact_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userList==null ? const RegisterPage() : const ContactPage()
    );
  }
}
