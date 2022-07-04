import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ig_clone/responsive/mobile_screen_layout.dart';
import 'package:ig_clone/responsive/responsive_layout_screen.dart';
import 'package:ig_clone/responsive/web_screen_layout.dart';
import 'package:ig_clone/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JJ Grams',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: const ResponsiveLayout( // const since no dynamic values used in constructors
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ));
  }
}
