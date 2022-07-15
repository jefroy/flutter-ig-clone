import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ig_clone/providers/user_provider.dart';
import 'package:ig_clone/resources/firestore_methods.dart';
import 'package:ig_clone/utils/colors.dart';
import 'package:ig_clone/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('comment hehe'),
    );
  }
}
