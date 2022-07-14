import 'package:flutter/material.dart';
import 'package:ig_clone/screens/add_post_screen.dart';
import 'package:ig_clone/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('notif'),
  Text('profile'),
];
