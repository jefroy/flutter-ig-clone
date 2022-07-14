import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ig_clone/providers/user_provider.dart';
import 'package:ig_clone/resources/firestore_methods.dart';
import 'package:ig_clone/utils/colors.dart';
import 'package:ig_clone/utils/utils.dart';
import 'package:ig_clone/widgets/post_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline_rounded),
          ),
        ],
      ),
      body: const PostCard(),
    );
  }
}
