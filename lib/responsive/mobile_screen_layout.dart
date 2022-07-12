import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ig_clone/models/custom_user.dart';
import 'package:ig_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MobileScreenLayoutState();
  }
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

  @override
  Widget build(BuildContext context) {
    CustomUser user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: Text("MOBILE VIEW\n${user.username}"),
      ),
    );
  }

}
