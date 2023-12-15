import 'package:flutter/material.dart';

class UserProfiled extends StatefulWidget {
  const UserProfiled({super.key});

  @override
  State<UserProfiled> createState() => _UserProfiledState();
}

class _UserProfiledState extends State<UserProfiled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("   Profile",style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white
        ),),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
