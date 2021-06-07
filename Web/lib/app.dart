import 'package:flutter/material.dart';
import 'package:web_application/views/edit_profile.dart';
import 'package:web_application/views/login_page.dart';
import 'package:web_application/views/profile_page.dart';
import 'package:web_application/views/register_complete.dart';
import 'package:web_application/views/register_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),




    theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true, fillColor: Colors.amber[50],
          hintStyle: TextStyle(color: Color(0xFFF55317)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(48),
            borderSide: BorderSide(color: Colors.amber[50]!,)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(48),
            borderSide: BorderSide(color: Colors.amber[50]!,)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(48),
              borderSide: BorderSide(color: Colors.amber,width: 2)
          )
        )
    ),

    );

  }
}
